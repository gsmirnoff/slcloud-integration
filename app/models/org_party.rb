class OrgParty < SalesParty
  attr_accessor :id, :name, :ceo, :established
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
    response = client.call(:find_sales_party, message: FindCriteria.new('typ1', {:party_type => 'ORGANIZATION'}))
    if response.success?
      data = response.to_array(:find_sales_party_response, :result)
      if data
        data.each do |item|
          organization = item[:organization_party]
          sales_party = self.new({:id => item[:party_id],
                                  :name => item[:party_name],
                                  :ceo => organization[:ceo_name],
                                  :established => organization[:year_established]
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
                    'org:CeoName' => ceo,
                    'org:YearEstablished' => established,
                    'org:CreatedByModule' => 'SALES'
                },
                'org:CreatedByModule' => 'SALES'
            }
        }
    })
  end
end