Rails.application.routes.draw do
  resources :messages

  post 'invitation/generate', :as => 'invitation_generate'
  post 'invitation/apply', :as => 'invitation_apply'
  get 'token/:token' => 'invitation#apply', :as => 'token_apply'
  get 'token' => 'invitation#apply'
  get 'invitation/submit', :as => 'invitation_submit'
  post 'invitation/submit', :as => 'invitation_post'
  get 'invitations' => 'invitation#index', :as => 'invitations'

  post 'datum/update', :as => 'datum_update'
  post 'score/update', :as => 'score_update'

    root "welcome#index"

    resources :scholarships do
        member do
            get 'assign'
            get 'admin'
        end
        resources :sections do
            resources :fields
        end
        resources :reviews do
            get 'print', on: :collection
        end
    end

    resources :users do
        member do
            get 'promote'
        end
        resources :applications do
            get 'review', on: :member
        end
    end

    get "sign-in" => 'sessions#new', :as => 'sign_in'
    get "sign-up" => 'users#new', :as => 'sign_up'
    post "sign-in" => 'sessions#create', :as => 'session_create'
    get "sign-out" => 'sessions#destroy', :as => 'sign_out'
    get "me" => 'users#show', :as => 'me'

    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # You can have the root of your site routed with "root"

    # Example of regular route:
    #   get 'products/:id' => 'catalog#view'

    # Example of named route that can be invoked with purchase_url(id: product.id)
    #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

    # Example resource route (maps HTTP verbs to controller actions automatically):
    #   resources :products

    # Example resource route with options:
    #   resources :products do
    #     member do
    #       get 'short'
    #       post 'toggle'
    #     end
    #
    #     collection do
    #       get 'sold'
    #     end
    #   end

    # Example resource route with sub-resources:
    #   resources :products do
    #     resources :comments, :sales
    #     resource :seller
    #   end

    # Example resource route with more complex sub-resources:
    #   resources :products do
    #     resources :comments
    #     resources :sales do
    #       get 'recent', on: :collection
    #     end
    #   end

    # Example resource route with concerns:
    #   concern :toggleable do
    #     post 'toggle'
    #   end
    #   resources :posts, concerns: :toggleable
    #   resources :photos, concerns: :toggleable

    # Example resource route within a namespace:
    #   namespace :admin do
    #     # Directs /admin/products/* to Admin::ProductsController
    #     # (app/controllers/admin/products_controller.rb)
    #     resources :products
    #   end
end
