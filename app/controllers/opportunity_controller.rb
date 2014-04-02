class OpportunityController < ApplicationController
  def list
    @party_id = params[:party_id]
  end

  def get_opportunities
    puts params
    @opportunities = Opportunity.find_all(params[:party_id])
    @party_id = params[:party_id]
    render :partial => 'table_contents', :layout => false
  end

  def new
    @party_id = params[:party_id]
    @opportunity = Opportunity.new({})
  end

  def create
    @opportunity = Opportunity.new(params[:opportunity])
    @opportunity.create
    redirect_to action: :list, :party_id => @opportunity.party_id
  end

  def delete
    Opportunity.delete(params[:id])
    redirect_to action: :list, :party_id => params[:party_id]
  end
end

