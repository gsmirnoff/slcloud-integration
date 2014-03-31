Src::Application.routes.draw do

  root 'opportunity#list'

  get 'opportunities/list', to: 'opportunity#list'
  get 'opportunities/getall', to: 'opportunity#get_opportunities'
  get 'opportunities/create/', to: 'opportunity#new'
  post 'opportunities/create/', to: 'opportunity#create'
  delete 'opportunities/delete/', to: 'opportunity#delete'

  get 'parties/list', to: 'sales_party#list'
  get 'parties/getall', to: 'sales_party#get_parties'
  get 'parties/create/', to: 'sales_party#new'
  post 'parties/create', to: 'sales_party#create'
  delete 'parties/delete', to: 'sales_party#delete'

  get 'leads/list', to: 'sales_lead#list'
  get 'leads/getall', to: 'sales_lead#get_leads'
  get 'leads/create/', to: 'sales_lead#new'
  post 'leads/create', to: 'sales_lead#create'
  delete 'leads/delete', to: 'sales_lead#delete'

end
