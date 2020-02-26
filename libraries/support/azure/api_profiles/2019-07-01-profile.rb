# Profile definition targeted for hybrid applications that could run on azure gov general availability version and azure cloud
module Azure
  AZURE_REST_PROFILE_2019_07_01_profile = {
    "microsoft.adhybridhealthservice" => {
      "services" => "2014-01-01",
      "addsservices" => "2014-01-01",
      "configuration" => "2014-01-01",
      "operations" => "2014-01-01",
      "reports" => "2014-01-01"
    },
    "microsoft.advisor" => {
      "suppressions" => "2017-04-19",
      "configurations" => "2017-04-19",
      "recommendations" => "2017-04-19",
      "generaterecommendations" => "2017-04-19",
      "operations" => "2017-04-19"
    },
    "microsoft.alertsmanagement" => {
      "alerts" => "2018-05-05-preview",
      "alertssummary" => "2018-05-05-preview",
      "smartgroups" => "2018-05-05-preview",
      "operations" => "2018-05-05-preview"
    },
    "microsoft.analysisservices" => {
      "servers" => "2017-08-01-beta",
      "locations" => "2017-08-01-beta",
      "locations/checknameavailability" => "2017-08-01-beta",
      "locations/operationresults" => "2017-08-01-beta",
      "locations/operationstatuses" => "2017-08-01-beta",
      "operations" => "2017-08-01-beta"
    },
    "microsoft.apimanagement" => {
      "service" => "2019-01-01",
      "checknameavailability" => "2019-01-01"
    },
    "microsoft.authorization" => {
      "classicadministrators" => "2015-06-01",
      "denyassignments" => "2018-07-01-preview",
      "policydefinitions" => "2018-05-01",
      "policysetdefinitions" => "2018-05-01",
      "policyassignments" => "2018-05-01",
      "roledefinitions" => "2018-01-01-preview"
    },
    "microsoft.automation" => {
      "automationaccounts" => "2015-10-31"
    },
    "microsoft.azurestack" => {
      "operations" => "2017-06-01",
      "registrations" => "2017-06-01",
      "registrations/products" => "2017-06-01",
      "registrations/customersubscriptions" => "2017-06-01"
    },
    "microsoft.batch" => {
      "batchaccounts" => "2019-04-01",
      "operations" => "2019-04-01",
      "locations" => "2019-04-01",
      "locations/quotas" => "2019-04-01",
      "locations/checknameavailability" => "2019-04-01"
    },
    "microsoft.batchai" => {
      "clusters" => "2018-03-01",
      "jobs" => "2018-03-01",
      "fileservers" => "2018-03-01",
      "workspaces" => "2018-05-01",
      "workspaces/clusters" => "2018-05-01",
      "workspaces/fileservers" => "2018-05-01",
      "workspaces/experiments" => "2018-05-01",
      "workspaces/experiments/jobs" => "2018-05-01",
      "operations" => "2018-05-01",
      "locations" => "2018-05-01",
      "locations/usages" => "2018-05-01"
    },
    "microsoft.botservice" => {
      "botservices" => "2018-07-12",
      "botservices/channels" => "2018-07-12",
      "botservices/connections" => "2018-07-12",
      "listauthserviceproviders" => "2018-07-12",
      "checknameavailability" => "2018-07-12",
      "operations" => "2018-07-12"
    },
    "microsoft.cache" => {
      "redis" => "2018-03-01",
      "checknameavailability" => "2018-03-01",
      "operations" => "2018-03-01"
    },
    "microsoft.cognitiveservices" => {
      "accounts" => "2017-04-18",
      "operations" => "2017-04-18",
      "locations" => "2017-04-18",
      "locations/checkskuavailability" => "2017-04-18",
      "skus" => "2017-04-18"
    },
    "microsoft.compute" => {
      "galleries" => "2019-03-01",
      "galleries/images" => "2019-03-01",
      "galleries/images/versions" => "2019-03-01",
      "availabilitysets" => "2018-10-01",
      "virtualmachines" => "2018-10-01",
      "virtualmachines/extensions" => "2018-10-01",
      "virtualmachinescalesets" => "2018-10-01",
      "virtualmachinescalesets/extensions" => "2018-10-01",
      "virtualmachinescalesets/virtualmachines" => "2018-10-01",
      "locations" => "2018-10-01",
      "locations/vmsizes" => "2018-10-01",
      "locations/runcommands" => "2018-10-01",
      "locations/usages" => "2018-10-01",
      "locations/virtualmachines" => "2018-10-01",
      "locations/publishers" => "2018-10-01",
      "operations" => "2018-10-01",
      "images" => "2018-10-01",
      "disks" => "2018-09-30",
      "snapshots" => "2018-09-30"
    },
    "microsoft.consumption" => {
      "costtags" => "2018-06-30",
      "credits" => "2018-11-01-preview",
      "events" => "2018-11-01-preview",
      "lots" => "2018-11-01-preview"
    },
    "microsoft.containerregistry" => {
      "registries" => "2017-10-01",
      "registries/importimage" => "2017-10-01",
      "registries/replications" => "2017-10-01",
      "registries/webhooks" => "2017-10-01",
      "registries/webhooks/ping" => "2017-10-01",
      "registries/webhooks/getcallbackconfig" => "2017-10-01",
      "registries/webhooks/listevents" => "2017-10-01",
      "registries/listcredentials" => "2017-10-01",
      "registries/regeneratecredential" => "2017-10-01",
      "registries/listusages" => "2017-10-01",
      "checknameavailability" => "2017-10-01",
      "operations" => "2017-10-01",
      "registries/getcredentials" => "2016-06-27-preview",
      "registries/regeneratecredentials" => "2016-06-27-preview"
    },
    "microsoft.costmanagement" => {
      "reportconfigs" => "2018-05-31"
    },
    "microsoft.databox" => {
      "jobs" => "2018-01-01",
      "locations" => "2018-01-01",
      "locations/validateaddress" => "2018-01-01",
      "operations" => "2018-01-01",
      "locations/availableskus" => "2018-01-01"
    },
    "microsoft.datafactory" => {
      "factories" => "2018-06-01",
      "factories/integrationruntimes" => "2018-06-01",
      "operations" => "2018-06-01",
      "locations" => "2018-06-01",
      "locations/configurefactoryrepo" => "2018-06-01",
      "locations/getfeaturevalue" => "2018-06-01"
    },
    "microsoft.datamigration" => {
      "locations" => "2018-07-15-preview",
      "services" => "2018-07-15-preview",
      "services/projects" => "2018-07-15-preview",
      "locations/checknameavailability" => "2018-07-15-preview",
      "operations" => "2018-07-15-preview"
    },
    "microsoft.dbformysql" => {
      "operations" => "2017-12-01-preview",
      "servers" => "2017-12-01-preview",
      "servers/virtualnetworkrules" => "2017-12-01-preview",
      "checknameavailability" => "2017-12-01-preview",
      "locations" => "2017-12-01-preview",
      "locations/performancetiers" => "2017-12-01-preview"
    },
    "microsoft.dbforpostgresql" => {
      "operations" => "2017-12-01-preview",
      "servers" => "2017-12-01-preview",
      "servers/virtualnetworkrules" => "2017-12-01-preview",
      "checknameavailability" => "2017-12-01-preview",
      "locations" => "2017-12-01-preview",
      "locations/performancetiers" => "2017-12-01-preview"
    },
    "microsoft.devices" => {
      "checknameavailability" => "2018-12-01-preview",
      "usages" => "2018-12-01-preview",
      "operations" => "2018-12-01-preview",
      "iothubs" => "2018-12-01-preview"
    },
    "microsoft.eventhub" => {
      "namespaces" => "2018-01-01-preview",
      "clusters" => "2018-01-01-preview",
      "checknamespaceavailability" => "2014-09-01",
      "checknameavailability" => "2017-04-01",
      "sku" => "2017-04-01",
      "operations" => "2017-04-01"
    },
    "microsoft.features" => {
      "features" => "2015-12-01",
      "providers" => "2015-12-01"
    },
    "microsoft.importexport" => {
      "jobs" => "2016-11-01",
      "locations" => "2016-11-01",
      "operations" => "2016-11-01"
    },
    "microsoft.insights" => {
      "scheduledqueryrules" => "2018-04-16",
      "logprofiles" => "2016-03-01",
      "alertrules" => "2016-03-01",
      "metricalerts" => "2018-03-01",
      "webtests" => "2015-05-01",
      "autoscalesettings" => "2015-04-01",
      "operations" => "2015-04-01",
      "eventcategories" => "2015-04-01",
      "diagnosticsettings" => "2017-05-01-preview",
      "diagnosticsettingscategories" => "2017-05-01-preview",
      "workbooks" => "2018-06-17-preview",
      "metricdefinitions" => "2018-01-01",
      "metrics" => "2018-01-01",
      "actiongroups" => "2018-09-01",
      "baseline" => "2018-09-01",
      "calculatebaseline" => "2018-09-01",
      "activitylogalerts" => "2017-04-01",
      "components/pricingplans" => "2017-10-01",
      "migratetonewpricingmodel" => "2017-10-01",
      "rollbacktolegacypricingmodel" => "2017-10-01",
      "listmigrationdate" => "2017-10-01"
    },
    "microsoft.keyvault" => {
      "vaults" => "2018-02-14-preview",
      "vaults/secrets" => "2018-02-14-preview",
      "vaults/accesspolicies" => "2018-02-14-preview",
      "operations" => "2018-02-14-preview",
      "checknameavailability" => "2018-02-14-preview",
      "deletedvaults" => "2018-02-14-preview",
      "locations" => "2018-02-14-preview",
      "locations/deletedvaults" => "2018-02-14-preview"
    },
    "microsoft.logic" => {
      "integrationaccounts" => "2018-07-01-preview"
    },
    "microsoft.marketplaceordering" => {
      "agreements" => "2015-06-01",
      "operations" => "2015-06-01",
      "offertypes" => "2015-06-01"
    },
    "microsoft.media" => {
      "mediaservices" => "2018-07-01",
      "mediaservices/assets" => "2018-07-01",
      "mediaservices/contentkeypolicies" => "2018-07-01",
      "mediaservices/streaminglocators" => "2018-07-01",
      "mediaservices/streamingpolicies" => "2018-07-01",
      "mediaservices/transforms" => "2018-07-01",
      "mediaservices/transforms/jobs" => "2018-07-01",
      "mediaservices/streamingendpoints" => "2018-07-01",
      "mediaservices/liveevents" => "2018-07-01",
      "mediaservices/liveevents/liveoutputs" => "2018-07-01",
      "mediaservices/assets/assetfilters" => "2018-07-01",
      "mediaservices/accountfilters" => "2018-07-01",
      "operations" => "2018-07-01",
      "locations" => "2018-07-01",
      "locations/checknameavailability" => "2018-07-01",
      "checknameavailability" => "2015-10-01"
    },
    "microsoft.migrate" => {
      "projects" => "2018-02-02",
      "operations" => "2018-02-02",
      "locations" => "2018-02-02",
      "locations/checknameavailability" => "2018-02-02",
      "locations/assessmentoptions" => "2018-02-02"
    },
    "microsoft.network" => {
      "virtualnetworks" => "2019-02-01",
      "publicipaddresses" => "2019-02-01",
      "networkinterfaces" => "2019-02-01",
      "loadbalancers" => "2019-02-01",
      "networksecuritygroups" => "2019-02-01",
      "applicationsecuritygroups" => "2019-02-01",
      "serviceendpointpolicies" => "2019-02-01",
      "routetables" => "2019-02-01",
      "publicipprefixes" => "2019-02-01",
      "ddoscustompolicies" => "2019-02-01",
      "networkwatchers" => "2019-02-01",
      "networkwatchers/connectionmonitors" => "2019-02-01",
      "virtualnetworkgateways" => "2019-02-01",
      "localnetworkgateways" => "2019-02-01",
      "connections" => "2019-02-01",
      "applicationgateways" => "2019-02-01",
      "applicationgatewaywebapplicationfirewallpolicies" => "2019-02-01",
      "locations" => "2019-02-01",
      "locations/checkdnsnameavailability" => "2019-02-01",
      "locations/usages" => "2019-02-01",
      "locations/virtualnetworkavailableendpointservices" => "2019-02-01",
      "locations/availabledelegations" => "2019-02-01",
      "operations" => "2019-02-01",
      "expressroutecircuits" => "2019-02-01",
      "expressroutecrossconnections" => "2019-02-01",
      "expressrouteserviceproviders" => "2019-02-01",
      "applicationgatewayavailablewafrulesets" => "2019-02-01",
      "applicationgatewayavailablessloptions" => "2019-02-01",
      "applicationgatewayavailableservervariables" => "2019-02-01",
      "applicationgatewayavailablerequestheaders" => "2019-02-01",
      "applicationgatewayavailableresponseheaders" => "2019-02-01",
      "routefilters" => "2019-02-01",
      "bgpservicecommunities" => "2019-02-01",
      "azurefirewalls" => "2019-02-01",
      "azurefirewallfqdntags" => "2019-02-01",
      "virtualnetworktaps" => "2019-02-01",
      "ddosprotectionplans" => "2019-02-01",
      "networkprofiles" => "2019-02-01",
      "dnszones" => "2018-05-01",
      "dnszones/a" => "2018-05-01",
      "trafficmanagerprofiles" => "2018-04-01",
      "checktrafficmanagernameavailability" => "2018-04-01",
      "trafficmanagergeographichierarchies" => "2018-04-01"
    },
    "microsoft.notificationhubs" => {
      "namespaces" => "2017-04-01",
      "namespaces/notificationhubs" => "2017-04-01",
      "checknamespaceavailability" => "2017-04-01",
      "operations" => "2017-04-01"
    },
    "microsoft.operationalinsights" => {
      "linktargets" => "2015-03-20"
    },
    "microsoft.operationsmanagement" => {
      "solutions" => "2015-11-01-preview",
      "operations" => "2015-11-01-preview"
    },
    "microsoft.policyinsights" => {
      "policyevents" => "2018-04-04",
      "policystates" => "2018-07-01-preview",
      "operations" => "2018-07-01-preview",
      "remediations" => "2018-07-01-preview",
      "policytrackedresources" => "2018-07-01-preview"
    },
    "microsoft.portal" => {
      "dashboards" => "2015-08-01-preview"
    },
    "microsoft.powerbi" => {
      "workspacecollections" => "2016-01-29",
      "locations" => "2016-01-29",
      "locations/checknameavailability" => "2016-01-29"
    },
    "microsoft.powerbidedicated" => {
      "capacities" => "2017-10-01",
      "locations/checknameavailability" => "2017-10-01"
    },
    "microsoft.recoveryservices" => {
      "operations" => "2016-08-10",
      "locations" => "2016-06-01",
      "locations/checknameavailability" => "2016-06-01",
      "locations/backupvalidatefeatures" => "2017-07-01",
      "locations/backupstatus" => "2017-07-01",
      "locations/backupprevalidateprotection" => "2017-07-01"
    },
    "microsoft.relay" => {
      "namespaces" => "2017-04-01",
      "checknameavailability" => "2017-04-01",
      "operations" => "2017-04-01"
    },
    "microsoft.resourcehealth" => {
      "availabilitystatuses" => "2017-07-01",
      "operations" => "2015-01-01"
    },
    "microsoft.resources" => {
      "providers" => "2016-09-01",
      "resources" => "2016-09-01",
      "subscriptions/resources" => "2016-09-01",
      "subscriptions/providers" => "2016-09-01",
      "resourcegroups" => "2016-09-01",
      "subscriptions/resourcegroups" => "2016-09-01",
      "subscriptions/resourcegroups/resources" => "2016-09-01",
      "subscriptions/tagnames" => "2016-09-01",
      "subscriptions/tagnames/tagvalues" => "2016-09-01",
      "deployments" => "2016-09-01",
      "deployments/operations" => "2016-09-01",
      "links" => "2016-09-01",
      "subscriptions" => "2016-06-01"
    },
    "microsoft.scheduler" => {
      "jobcollections" => "2016-03-01"
    },
    "microsoft.search" => {
      "searchservices" => "2015-08-19",
      "checknameavailability" => "2015-08-19",
      "operations" => "2015-08-19"
    },
    "microsoft.servicebus" => {
      "namespaces" => "2018-01-01-preview",
      "namespaces/authorizationrules" => "2017-04-01",
      "namespaces/queues" => "2017-04-01",
      "namespaces/queues/authorizationrules" => "2017-04-01",
      "namespaces/topics" => "2017-04-01",
      "namespaces/topics/authorizationrules" => "2017-04-01",
      "namespaces/topics/subscriptions" => "2017-04-01",
      "namespaces/topics/subscriptions/rules" => "2017-04-01",
      "checknameavailability" => "2017-04-01",
      "sku" => "2017-04-01",
      "premiummessagingregions" => "2017-04-01",
      "operations" => "2017-04-01"
    },
    "microsoft.servicefabric" => {
      "clusters" => "2018-02-01",
      "locations" => "2018-02-01",
      "locations/clusterversions" => "2018-02-01",
      "operations" => "2018-02-01"
    },
    "microsoft.solutions" => {
      "applications" => "2018-06-01",
      "applicationdefinitions" => "2018-06-01"
    },
    "microsoft.sql" => {
      "servers/databases/backuplongtermretentionpolicies" => "2014-04-01",
      "servers/databases/transparentdataencryption" => "2014-04-01",
      "servers/databases/geobackuppolicies" => "2014-04-01",
      "operations" => "2017-03-01-preview",
      "locations/manageddatabaserestoreazureasyncoperation" => "2017-03-01-preview",
      "servers/automatictuning" => "2017-03-01-preview",
      "servers/securityalertpolicies" => "2017-03-01-preview",
      "servers/extendedauditingsettings" => "2017-03-01-preview",
      "servers/jobagents" => "2017-03-01-preview",
      "servers/jobagents/jobs" => "2017-03-01-preview",
      "servers/jobagents/jobs/steps" => "2017-03-01-preview",
      "servers/jobagents/jobs/executions" => "2017-03-01-preview",
      "servers/dnsaliases" => "2017-03-01-preview",
      "servers/databases/vulnerabilityassessment" => "2017-03-01-preview",
      "managedinstances/administrators" => "2017-03-01-preview",
      "managedinstances/databases" => "2017-03-01-preview",
      "locations/longtermretentionservers" => "2017-03-01-preview",
      "locations/longtermretentionbackups" => "2017-03-01-preview",
      "servers" => "2018-06-01-preview",
      "servers/databases" => "2018-06-01-preview",
      "servers/databases/securityalertpolicies" => "2018-06-01-preview",
      "servers/vulnerabilityassessments" => "2018-06-01-preview",
      "managedinstances/vulnerabilityassessments" => "2018-06-01-preview",
      "managedinstances" => "2018-06-01-preview",
      "locations/capabilities" => "2017-10-01-preview",
      "servers/tdecertificates" => "2017-10-01-preview",
      "servers/elasticpools" => "2017-10-01-preview",
      "servers/databases/vulnerabilityassessments" => "2017-10-01-preview",
      "managedinstances/databases/vulnerabilityassessments" => "2017-10-01-preview",
      "managedinstances/recoverabledatabases" => "2017-10-01-preview",
      "managedinstances/tdecertificates" => "2017-10-01-preview",
      "locations/instancefailovergroups" => "2017-10-01-preview",
      "servers/keys" => "2015-05-01-preview",
      "servers/encryptionprotector" => "2015-05-01-preview",
      "servers/databases/automatictuning" => "2015-05-01-preview",
      "servers/failovergroups" => "2015-05-01-preview",
      "servers/virtualnetworkrules" => "2015-05-01-preview",
      "servers/advisors" => "2015-05-01-preview",
      "servers/databases/advisors" => "2015-05-01-preview",
      "servers/databases/syncgroups" => "2015-05-01-preview",
      "servers/databases/syncgroups/syncmembers" => "2015-05-01-preview",
      "servers/syncagents" => "2015-05-01-preview",
      "virtualclusters" => "2015-05-01-preview",
      "locations/syncdatabaseids" => "2015-05-01-preview"
    },
    "microsoft.storage" => {
      "storageaccounts" => "2019-04-01",
      "operations" => "2019-04-01",
      "storageaccounts/listaccountsas" => "2019-04-01",
      "storageaccounts/listservicesas" => "2019-04-01",
      "storageaccounts/blobservices" => "2019-04-01",
      "storageaccounts/fileservices" => "2019-04-01",
      "locations/usages" => "2019-04-01",
      "checknameavailability" => "2019-04-01",
      "usages" => "2017-10-01"
    },
    "microsoft.storagesync" => {
      "storagesyncservices" => "2019-02-01",
      "storagesyncservices/syncgroups" => "2019-02-01",
      "storagesyncservices/syncgroups/cloudendpoints" => "2019-02-01",
      "storagesyncservices/syncgroups/serverendpoints" => "2019-02-01",
      "storagesyncservices/registeredservers" => "2019-02-01",
      "storagesyncservices/workflows" => "2019-02-01",
      "operations" => "2019-02-01",
      "locations" => "2019-02-01",
      "locations/checknameavailability" => "2019-02-01"
    },
    "microsoft.web" => {
      "publishingusers" => "2018-02-01",
      "sourcecontrols" => "2018-02-01",
      "availablestacks" => "2018-02-01",
      "listsitesassignedtohostname" => "2018-02-01",
      "sites/hostnamebindings" => "2018-02-01",
      "sites/slots/hostnamebindings" => "2018-02-01",
      "operations" => "2018-02-01",
      "serverfarms" => "2018-02-01",
      "georegions" => "2018-02-01",
      "sites/premieraddons" => "2018-02-01",
      "deploymentlocations" => "2018-02-01",
      "checknameavailability" => "2018-02-01",
      "billingmeters" => "2018-02-01",
      "hostingenvironments" => "2018-02-01",
      "hostingenvironments/multirolepools" => "2018-02-01",
      "hostingenvironments/workerpools" => "2018-02-01",
      "connections" => "2016-06-01",
      "customapis" => "2016-06-01",
      "locations" => "2016-06-01",
      "locations/managedapis" => "2016-06-01",
      "connectiongateways" => "2016-06-01",
      "ishostingenvironmentnameavailable" => "2015-08-01"
    }
  }
end
