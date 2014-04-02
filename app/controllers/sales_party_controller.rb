class SalesPartyController < ApplicationController
  def list
  end

  def get_parties
    @sales_parties = OrgParty.find_all
    render :partial => 'table_contents', :layout => false
  end

  def new
    @sales_party = OrgParty.new({})
  end

  def create
    @sales_party = OrgParty.new(params[:sales_party])
    @sales_party.create
    redirect_to action: :list
  end

  def delete
    OrgParty.delete(params[:id])
    redirect_to action: :list
  end
end
