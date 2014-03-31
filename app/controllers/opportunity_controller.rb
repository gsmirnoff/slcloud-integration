class OpportunityController < ApplicationController
  def list
  end

  def get_opportunities
    @opportunities = Opportunity.find_all
    render :partial => 'table_contents', :layout => false
  end

  def new
    @opportunity = Opportunity.new({})
  end

  def create
    @opportunity = Opportunity.new(params[:opportunity])
    @opportunity.create
    redirect_to action: :list
  end

  def delete
    Opportunity.delete(params[:id])
    redirect_to action: :list
  end
end

