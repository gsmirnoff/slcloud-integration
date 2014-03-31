class SalesLead
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  attr_accessor :id, :name, :created_date, :created_by, :description, :currency_code

  def self.get_client
    return Savon.client(
        basic_auth: ["matt.hooper", "MeAcome01"],
        wsdl: 'https://isv1-crm-crm-ext.oracle.com/mklLeads/SalesLeadService?wsdl',
        ssl_verify_mode: :none,
        env_namespace: :soapenv,
        namespace_identifier: :typ,
        pretty_print_xml: true,
        namespaces: {
            'xmlns:typ' => 'http://xmlns.oracle.com/apps/marketing/leadMgmt/leads/leadService/types/',
            'xmlns:typ1' => 'http://xmlns.oracle.com/adf/svc/types/',
            'xmlns:lead' => 'http://xmlns.oracle.com/oracle/apps/marketing/leadMgmt/leads/leadService/'
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
  end

  def self.find_all
    res = []
    client = get_client
    response = client.call(:find_sales_lead, message: {
        'typ:findCriteria' => {
            'typ1:fetchStart' => 0,
            'typ1:fetchSize' => -1
        },
        'typ:findControl' => {
            'typ1:retrieveAllTranslations' => false
        }
    })
    if response.success?
      data = response.to_array(:find_sales_lead_response, :result)
      if data
        data.each do |item|
          sales_lead = self.new({:id => item[:lead_id],
                                  :name => item[:name],
                                  :created_date => item[:creation_date],
                                  :created_by => item[:created_by],
                                  :description => item[:description],
                                  :currency_code => item[:currency_code]
                                 })
          res.push(sales_lead)
        end
      end
    end
    return res
  end

  def create
    client = self.class.get_client
    response = client.call(:create_sales_lead, message: {
        'typ:salesParty' => {
            'lead:Description' => description,
            'lead:Name' => name
        }
    })
  end

  def self.delete(id)
    client = get_client
    response = client.call(:delete_sales_lead, message: {
        'typ:opportunity' => {
            'lead:LeadId' => id
        }
    })
  end
end
