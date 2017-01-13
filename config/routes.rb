Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'notes#index'
  resources :notes, :only => [:index, :new, :create, :edit, :update] do
    member do
      get  'rollback'
    end
  end
end
