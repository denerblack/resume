Rails.application.routes.draw do
  get 'home/download_curriculum', to: "home#download_curriculum"

  get '/', to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
