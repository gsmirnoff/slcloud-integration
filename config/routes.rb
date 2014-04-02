Src::Application.routes.draw do

  root 'sales_party#list'

  get 'opportunities/list', to: 'opportunity#list'
  get 'opportunities/getall', to: 'opportunity#get_opportunities'
  get 'opportunities/create', to: 'opportunity#new'
  post 'opportunities/create/', to: 'opportunity#create'
  delete 'opportunities/delete/', to: 'opportunity#delete'

  get 'parties/list', to: 'sales_party#list'
  get 'parties/getall', to: 'sales_party#get_parties'
  get 'parties/create/', to: 'sales_party#new'
  post 'parties/create', to: 'sales_party#create'
  delete 'parties/delete', to: 'sales_party#delete'

  get 'contacts/list', to: 'opportunity_contact#list'
  get 'contacts/getall', to: 'opportunity_contact#get_contact'
  get 'contacts/create/', to: 'opportunity_contact#new'
  post 'contacts/create', to: 'opportunity_contact#create'
  delete 'contacts/delete', to: 'opportunity_contact#delete'

end
