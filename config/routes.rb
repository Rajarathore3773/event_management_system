Rails.application.routes.draw do
  devise_for :users
  
   root to: "home#index"
   resources :projects do
    member do
      get 'add_user', to: 'project_users#add_user'
      get 'edit_user', to: 'project_users#edit_user'
      patch 'update_user', to: 'project_users#update_user'
      delete 'remove_user', to: 'project_users#remove_user'
      post 'assign_role',to: 'project_users#assign_role'
    end
    #this route is collection route does not require id for assign role 
    # resources :project_users, only: [:create] do
    #   post 'assign_role', on: :collection
    # end
  end


end
