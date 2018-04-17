Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'books#index'
  #
  # get '/books', to: 'books#index', as: 'books'
  # get '/books/new', to: 'books#new', as: 'new_book'
  # post '/books', to: 'books#create'
  #
  # get '/books/:id', to: 'books#show', as: 'book'
  # get '/books/:id/edit', to: 'books#edit', as: 'edit_book'
  # patch '/books/:id', to: 'books#update'
  # delete '/books/:id', to: 'books#destroy'

  # You can replace all the RESTful routes above with resources

  root 'books#index'

  resources :books do

    # non-RESTful routes can be specified in a block
    # post '/check_out', to: 'books#check_out', as: 'check_out_book'

  end

  resources :authors do
    resources :books, only: [:index, :new]
  end

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  # Or, you can restrict what you want with :only or :except
  # resrouces :books, only: [:index, :new, :create]
  # resources :authors, except: [:destroy]


  # For non-RESTful routes, it can be specified in a block
  #  resources :books do

    # post '/check_out', to: 'books#check_out', as: 'check_out'

  #  end

  #  or, you can type them out maually
  #  post '/books/:id/check_out', to: 'books#check_out', as: 'check_out'
end
