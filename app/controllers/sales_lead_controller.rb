class SalesLeadController < ApplicationController
  def list
  end

  def get_leads
    @sales_leads = SalesLead.find_all
    render :partial => 'table_contents', :layout => false
  end

  def new
    @sales_lead = SalesLead.new({})
  end

  def create
    @sales_lead = SalesLead.new(params[:sales_lead])
    @sales_lead.create
    redirect_to action: :list
  end

  def delete
    SalesLead.delete(params[:id])
    redirect_to action: :list
  end
end
