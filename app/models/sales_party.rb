class SalesParty
  extend ActiveModel::Naming
  include ActiveModel::Conversion


  def self.get_client
    return Savon.client(
        basic_auth: ["matt.hooper", "MeAcome01"],
        wsdl: 'https://isv1-crm-crm-ext.oracle.com/crmCommonSalesParties/SalesPartyService?wsdl',
        ssl_verify_mode: :none,
        env_namespace: :soapenv,
        namespace_identifier: :typ,
        pretty_print_xml: true,
        namespaces: {
            'xmlns:typ' => 'http://xmlns.oracle.com/apps/crmCommon/salesParties/salesPartiesService/types/',
            'xmlns:typ1' => 'http://xmlns.oracle.com/adf/svc/types/',
            'xmlns:sal' => 'http://xmlns.oracle.com/apps/crmCommon/salesParties/salesPartiesService/',
            'xmlns:org' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/organizationService/',
            'xmlns:org1' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/flex/organization/',
            'xmlns:org2' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/flex/orgContact/',
            'xmlns:per' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/personService/',
            'xmlns:per1' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/flex/person/',
            'xmlns:par' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/partyService/',
            'xmlns:sour' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/flex/sourceSystemRef/',
            'xmlns:con' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/contactPointService/',
            'xmlns:con1' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/flex/contactPoint/',
            'xmlns:par1' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/flex/partySite/',
            'xmlns:rel' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/relationshipService/',
            'xmlns:rel1' => 'http://xmlns.oracle.com/apps/cdm/foundation/parties/flex/relationship/'
        }
    )
  end

  #no delete method in wsdl

end
