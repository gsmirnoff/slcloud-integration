class OpportunityController < ApplicationController
  def find_all
    @opportunities = Opportunity.find_all
  end

  def new
    @opportunity = Opportunity.new({})
  end

  def create
    @opportunity = Opportunity.new(params[:opportunity])
    @opportunity.create
    redirect_to action: :find_all
  end

  def delete
    Opportunity.delete(params[:id])
    redirect_to action: :find_all
  end
end
