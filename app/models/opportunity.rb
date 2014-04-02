class Opportunity
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  attr_accessor :id, :name, :revenue, :currency_code, :created_by, :description, :party_id, :key_contact

  def self.get_client
    return Savon.client(
        basic_auth: ["matt.hooper", "MeAcome01"],
        wsdl: 'https://isv1-crm-crm-ext.oracle.com/opptyMgmtOpportunities/OpportunityService?wsdl',
        ssl_verify_mode: :none,
        env_namespace: :soapenv,
        namespace_identifier: :typ,
        pretty_print_xml: true,
        namespaces: {
            'xmlns:typ' => 'http://xmlns.oracle.com/apps/sales/opptyMgmt/opportunities/opportunityService/types/',
            'xmlns:typ1' => 'http://xmlns.oracle.com/adf/svc/types/',
            'xmlns:opp' => 'http://xmlns.oracle.com/apps/sales/opptyMgmt/opportunities/opportunityService/'
        }
    )
  end

  def initialize(params)
    super()
    @id = params[:id]
    @name = params[:name]
    @revenue = params[:revenue]
    @currency_code = params[:currency_code]
    @created_by = params[:created_by]
    @description = params[:description]
    @party_id = params[:party_id]
    @key_contact = params[:key_contact]
  end

  def self.find_all(party_id)
    res = []
    client = get_client
    response = client.call(:find_opportunity, message: FindCriteria.new('typ1', {:primary_organization_id => party_id}))
    if response.success?
      data = response.to_array(:find_opportunity_response, :result)
      if data
        data.each do |item|
          opportunity = self.new({:id => item[:opty_id],
                                  :name => item[:name] || '',
                                  :revenue => item[:revenue],
                                  :currency_code => item[:currency_code],
                                  :created_by => item[:created_by],
                                  :description => item[:description],
                                  :key_contact => item[:key_contact_id],
                                  :party_id => party_id
                                 })
          res.push(opportunity)
        end
      end
    end
  return res
  end

  def create
    client = self.class.get_client
    response = client.call(:create_opportunity, message: {
        'typ:opportunity' => {
            'opp:Name' => name,
            'opp:Revenue' => revenue,
            'opp:CurrencyCode' => currency_code,
            'opp:Description' => description,
            'opp:PrimaryOrganizationId' => party_id,
        }
    })
  rescue Savon::SOAPFault => error
    puts error.to_hash[:fault]
  end

  def self.delete(id)
    client = get_client
    response = client.call(:delete_opportunity, message: {
        'typ:opportunity' => {
            'opp:OptyId' => id
        }
    })
  rescue Savon::SOAPFault => error
    puts error.to_hash[:fault]
  end

  def self.update_contact(id, contact_id)
    client = get_client
    response = client.call(:update_opportunity, message: {
        'typ:opportunity' => {
            'opp:OptyId' => id,
            'opp:KeyContactId' => contact_id
        }
    })
  end
end
