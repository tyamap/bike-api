Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :bikes, only: [ :index, :create ]
      put 'bikes' => 'bikes#update'
    end
  end
end
