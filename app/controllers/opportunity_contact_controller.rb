class OpportunityContactController < ApplicationController
  def list
    @opp_id = params[:opp_id]
    @key_contact = params[:key_contact]
  end

  def get_contact
    contact = params[:key_contact];
    if contact
      @contact = PersParty.get(contact)
    else
      @contact = nil
    end
    @opp_id = params[:opp_id]
    render :partial => 'table_contents', :layout => false
  end

  def new
    @opp_id = params[:opp_id]
    @contact = PersParty.new({})
  end

  def create
    opp_id = params[:pers_party][:opp_id]
    @contact = PersParty.new(params[:pers_party])
    party_id = @contact.create
    Opportunity.update_contact(opp_id, party_id)
    redirect_to action: :list, :opp_id => opp_id, :key_contact => party_id
  end

  def delete
    Opportunity.update_contact(params[:opp_id], nil)
    redirect_to action: :list, :opp_id => params[:opp_id], :key_contact => nil
  end
end
