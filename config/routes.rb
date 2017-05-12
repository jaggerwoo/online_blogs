Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/search_blog' => 'welcome#search_blog', as: :search_blog

  namespace :my_house do
    root 'blogs#index'
    resources :blogs do
      resources :blog_images, only:[:create, :destroy, :index]
    end
  end

  resources :blogs, only:[:show]
end
