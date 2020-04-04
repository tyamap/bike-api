Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :bikes, only: [ :index ] 
      post 'bikes' => 'bikes#create'
    end
  end
end
