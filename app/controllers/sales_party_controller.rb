class SalesPartyController < ApplicationController
  def list
  end

  def get_parties
    @sales_parties = SalesParty.find_all
    render :partial => 'table_contents', :layout => false
  end

  def new
    @sales_party = SalesParty.new({})
  end

  def create
    @sales_party = SalesParty.new(params[:sales_party])
    @sales_party.create
    redirect_to action: :list
  end

  def delete
    SalesParty.delete(params[:id])
    redirect_to action: :list
  end
end
