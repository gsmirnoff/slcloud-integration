class SalesParty
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  attr_accessor :id, :created_by, :name, :type, :status, :created_date

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

  def initialize(params)
    super()
    @id = params[:id]
    @name = params[:name]
    @type = params[:type]
    @status = params[:status]
    @created_date = params[:created_date]
    @created_by = params[:created_by]
    @email = params[:email]
  end

  def self.find_all
    res = []
    client = get_client
    response = client.call(:find_sales_party, message: {
        'typ:findCriteria' => {
            'typ1:fetchStart' => 0,
            'typ1:fetchSize' => -1
        },
        'typ:findControl' => {
            'typ1:retrieveAllTranslations' => false
        }
    })
    if response.success?
      data = response.to_array(:find_sales_party_response, :result)
      if data
        data.each do |item|
          sales_party = self.new({:id => item[:party_id],
                                  :name => item[:party_name],
                                  :type => item[:party_type],
                                  :status => item[:status],
                                  :created_by => item[:created_by],
                                  :created_date => item[:creation_date],
                                  :email => item[:email_address]
                                 })
          res.push(sales_party)
        end
      end
    end
    return res
  end

  def create
    client = self.class.get_client
    response = client.call(:create_sales_party, message: {
        'typ:salesParty' => {
            'sal:PartyName' => name,
            'sal:OrganizationParty' => {
                'org:OrganizationProfile' => {
                    'org:OrganizationName' => name,
                    'org:CreatedByModule' => 'SALES'
                },
                'org:CreatedByModule' => 'SALES'
            }
        }
    })
  rescue Savon::SOAPFault => error
    puts error.to_hash[:fault]
  end

  #no delete method in given webservice
  #def self.delete(id)
  #  client = get_client
  #  response = client.call(:delete_sales_account, message: {
  #      'typ:opportunity' => {
  #          'sal:PartyId' => id
  #      }
  #  })
  #end
end
