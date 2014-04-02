class PersParty < SalesParty
  attr_accessor :id, :name, :first_name, :last_name, :email, :opp_id
  def initialize(params)
    super()
    @id = params[:id]
    @name = params[:name]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @opp_id = params[:opp_id]
  end

  def self.find_all
    res = []
    client = get_client
    response = client.call(:find_sales_party, message: FindCriteria.new('typ1', {:party_type => 'PERSON'}))
    if response.success?
      data = response.to_array(:find_sales_party_response, :result)
      if data
        data.each do |item|
          person = item[:person_party]
          sales_party = self.new({:id => item[:party_id],
                                  :name => item[:party_name],
                                  :first_name => person[:person_first_name],
                                  :last_name => person[:person_last_name],
                                  :email => person[:email_address]
                                 })
          res.push(sales_party)
        end
      end
    end
    return res
  end

  def self.get(id)
    client = get_client
    response = client.call(:get_sales_party, message: {
        'typ:partyId' => id
    })
    if response.success?
      data = response.to_array(:get_sales_party_response, :result).first
      if data
          person = data[:person_party]
          sales_party = self.new({:id => data[:party_id],
                                  :name => data[:party_name],
                                  :first_name => person[:person_first_name],
                                  :last_name => person[:person_last_name],
                                  :email => person[:email_address]
                                 })
          return sales_party
      end
    end
  end

  def create
    client = self.class.get_client
    response = client.call(:create_sales_party, message: {
        'typ:salesParty' => {
            'sal:PartyName' => name,
            'sal:PersonParty' => {
                'per:Email' => {
                    'con:EmailAddress' => email,
                    'con:CreatedByModule' => 'SALES'
                },
                'per:PersonProfile' => {
                    'per:PersonFirstName' => first_name,
                    'per:PersonLastName' => last_name,
                    'per:CreatedByModule' => 'SALES'
                },
                'per:CreatedByModule' => 'SALES'
            }
        }
    })
    party = response.to_array(:create_sales_party_response, :result).first
    return party[:party_id]
  end
end