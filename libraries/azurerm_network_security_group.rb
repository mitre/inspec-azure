# frozen_string_literal: true

require 'azurerm_resource'

class AzurermNetworkSecurityGroup < AzurermSingularResource
  name 'azurerm_network_security_group'
  desc 'Verifies settings for Network Security Groups'
  example <<-EXAMPLE
    describe azurerm_network_security_group(resource_group: 'example', name: 'name') do
      its(name) { should eq 'name'}
    end
  EXAMPLE

  ATTRS = %i(
    name
    id
    etag
    type
    location
    tags
    properties
  ).freeze

  attr_reader(*ATTRS)

  def initialize(resource_group: nil, name: nil)
    return if name.nil? || resource_group.nil?
    
    resp = management.network_security_group(resource_group, name)
    return if has_error?(resp)

    assign_fields(ATTRS, resp)

    @exists = true
  end

  def to_s
    "'#{name}' Network Security Group"
  end

  def security_rules
    @security_rules ||= (@properties['securityRules']).sort_by { |rule| rule[:properties][:priority]}
  end

  def security_rules_inbound
    security_rules&.select { |rule| rule[:properties][:direction] == "Inbound" }
  end

  def security_rules_outbound
    security_rules&.select { |rule| rule[:properties][:direction] == "Outbound" }
  end

  def default_security_rules
    @default_security_rules ||= @properties['defaultSecurityRules']
  end

  def deny_by_default?
    inbound = security_rules_inbound.sort_by { |rule| rule[:properties][:priority]}.last
    outbound = security_rules_outbound.sort_by { |rule| rule[:properties][:priority]}.last

    rule_matches_config?(inbound, deny_by_default_config("inbound")) && \
    rule_matches_config?(outbound, deny_by_default_config("outbound"))
  end

  def match_security_config?(config, direction: nil)
    if config.nil?
      return false
    end

    if direction == "Outbound"
      rules = security_rules_outbound
    elsif direction == "Inbound"
      rules = security_rules_inbound
    else
      rules = security_rules
    end

    for rule in rules
      found = false
      # rule doesnt apply
      if rule.properties.direction != direction
        next
      end

      # continue to use up configs until you find a matching config
      for c in config
        if rule_matches_config?(rule, c)
          found = true
          break
        end
      end

      if !found
        # no more configs so fail
        return false
      end
    end

    true
  end

  def match_security_config_inbound?(config)
    match_security_config?(config, direction: "Inbound")
  end
  RSpec::Matchers.alias_matcher :match_security_config_inbound, :be_match_security_config_inbound

  def match_security_config_outbound?(config)
    match_security_config?(config, direction: "Outbound")
  end
  RSpec::Matchers.alias_matcher :match_security_config_outbound, :be_match_security_config_outbound

  def more_compact(l)
    l.select { |item| !item.nil? && item != "" }
  end

  def rule_matches_config?(rule, c)
    props_hash = rule.properties.to_h

    sourcePorts = more_compact([props_hash[:sourcePortRange]] + props_hash[:sourcePortRanges])
    destinationPorts = more_compact([props_hash[:destinationPortRange]] + props_hash[:destinationPortRanges])
    sourceAddress = more_compact([props_hash[:sourceAddressPrefix]] + props_hash[:sourceAddressPrefixes])
    destinationAddress = more_compact([props_hash[:destinationAddressPrefix]] + props_hash[:destinationAddressPrefixes])
    direction = props_hash[:direction]
    protocol = props_hash[:protocol]
    access = props_hash[:access]

    c[:sourcePorts] == sourcePorts && \
    c[:destinationPorts] == destinationPorts && \
    c[:sourceAddress] == sourceAddress && \
    c[:destinationAddress] == destinationAddress && \
    c[:direction].downcase == direction.downcase && \
    c[:protocol].downcase == protocol.downcase && \
    c[:access].downcase == access.downcase
  end

  SSH_CRITERIA = %i(ssh_port access_allow direction_inbound tcp source_open).freeze
  def allow_ssh_from_internet?
    @allow_ssh_from_internet ||= matches_criteria?(SSH_CRITERIA, security_rules_properties)
  end
  RSpec::Matchers.alias_matcher :allow_ssh_from_internet, :be_allow_ssh_from_internet

  RDP_CRITERIA = %i(rdp_port access_allow direction_inbound tcp source_open).freeze
  def allow_rdp_from_internet?
    @allow_rdp_from_internet ||= matches_criteria?(RDP_CRITERIA, security_rules_properties)
  end
  RSpec::Matchers.alias_matcher :allow_rdp_from_internet, :be_allow_rdp_from_internet

  private

  DENY_CONFIG = {
    :sourcePorts        => ["*"],
    :destinationPorts   => ["*"],
    :sourceAddress      => ["*"],
    :destinationAddress => ["*"],
    :protocol           => "*",
    :access             => "deny"
  }
  def deny_by_default_config(direction)
    c = DENY_CONFIG.clone
    c[:direction] = direction
    c
  end

  def security_rules_properties
    security_rules.collect { |rule| rule['properties'] }
  end

  def matches_criteria?(criteria, properties)
    properties.any? { |property| criteria.all? { |method| send(:"#{method}?", property) } }
  end

  def ssh_port?(properties)
    matches_port?(destination_port_ranges(properties), '22')
  end

  def rdp_port?(properties)
    matches_port?(destination_port_ranges(properties), '3389')
  end

  def destination_port_ranges(properties)
    properties_hash = properties.to_h
    return Array(properties['destinationPortRange']) if !properties_hash.include?(:destinationPortRanges)

    return properties['destinationPortRanges'] if !properties_hash.include?(:destinationPortRange)

    properties['destinationPortRanges'].push(properties['destinationPortRange'])
  end

  def matches_port?(ports, match_port)
    return true if ports.detect { |p| p =~ /^(#{match_port}|\*)$/ }

    ports.select { |port| port.include?('-') }
         .collect { |range| range.split('-') }
         .any? { |range| (range.first..range.last).cover?(match_port) }
  end

  def tcp?(properties)
    properties['protocol'].casecmp?('TCP')
  end

  def access_allow?(properties)
    properties['access'] == 'Allow'
  end

  def source_open?(properties)
    properties_hash = properties.to_h
    if properties_hash.include?(:sourceAddressPrefix)
      return properties['sourceAddressPrefix'] =~ %r{\*|0\.0\.0\.0|<nw>\/0|\/0|Internet|any}
    end
    if properties_hash.include?(:sourceAddressPrefixes)
      return properties['sourceAddressPrefixes'].include?('0.0.0.0')

    end
  end

  def direction_inbound?(properties)
    properties['direction'] == 'Inbound'
  end
end
