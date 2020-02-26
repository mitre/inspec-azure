# Profile definition targeted for hybrid applications that could run on azure stack general availability version and azure cloud
module Azure
  AZURE_REST_PROFILE_2017_03_09_profile = {
    "microsoft.authorization" => {
      "locks" => "2015-01-01",
      "operations" => "2015-07-01",
      "permissions" => "2015-07-01",
      "roleassignments" => "2015-07-01",
      "roledefinitions" => "2015-07-01",
      "policyassignments" => "2015-10-01-preview",
      "policydefinitions" => "2015-10-01-preview",
      "provideroperations" => "2015-07-01-preview"
    },
    "microsoft.compute" => {
      "availabilitysets" => "2016-03-30",
      "locations" => "2016-03-30",
      "locations/publishers" => "2016-03-30",
      "locations/operations" => "2016-03-30",
      "locations/usages" => "2016-03-30",
      "locations/vmsizes" => "2016-03-30",
      "operations" => "2016-03-30",
      "virtualmachines" => "2016-03-30",
      "virtualmachines/extensions" => "2016-03-30",
      "virtualmachinescalesets" => "2016-03-30",
      "virtualmachinescalesets/extensions" => "2016-03-30",
      "virtualmachinescalesets/networkinterfaces" => "2016-03-30",
      "virtualmachinescalesets/virtualmachines" => "2016-03-30",
      "virtualmachinescalesets/virtualmachines/networkinterfaces" => "2016-03-30"
    },
    "microsoft.keyvault" => {
      "operations" => "2016-10-01",
      "vaults" => "2016-10-01",
      "vaults/accesspolicies" => "2016-10-01",
      "vaults/secrets" => "2016-10-01"
    },
    "microsoft.network" => {
      "connections" => "2015-06-15",
      "loadbalancers" => "2015-06-15",
      "localnetworkgateways" => "2015-06-15",
      "locations" => "2015-06-15",
      "locations/operationresults" => "2015-06-15",
      "locations/operations" => "2015-06-15",
      "locations/usages" => "2015-06-15",
      "networkinterfaces" => "2015-06-15",
      "networksecuritygroups" => "2015-06-15",
      "operations" => "2015-06-15",
      "publicipaddresses" => "2015-06-15",
      "routetables" => "2015-06-15",
      "virtualnetworkgateways" => "2015-06-15",
      "virtualnetworks" => "2015-06-15",
      "dnszones" => "2016-04-01"
    },
    "microsoft.resources" => {
      "deployments" => "2016-02-01",
      "deployments/operations" => "2016-02-01",
      "locations" => "2016-02-01",
      "operations" => "2016-02-01",
      "providers" => "2016-02-01",
      "resourcegroups" => "2016-02-01",
      "resources" => "2016-02-01",
      "tenants" => "2016-02-01",
      "links" => "2016-09-01",
      "subscriptions" => "2016-06-01",
      "subscriptions/locations" => "2016-06-01",
      "subscriptions/operationresults" => "2016-06-01",
      "subscriptions/providers" => "2016-06-01",
      "subscriptions/resourcegroups" => "2016-06-01",
      "subscriptions/resourcegroups/resources" => "2016-06-01",
      "subscriptions/resources" => "2016-06-01",
      "subscriptions/tagnames" => "2016-06-01",
      "subscriptions/tagnames/tagvalues" => "2016-06-01"
    },
    "microsoft.storage" => {
      "checknameavailability" => "2016-01-01",
      "locations" => "2016-01-01",
      "locations/quotas" => "2016-01-01",
      "operations" => "2016-01-01",
      "storageaccounts" => "2016-01-01",
      "usages" => "2016-01-01"
    }
  }
end
