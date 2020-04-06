Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get   'bikes' => 'bikes#index'
      post  'bikes' => 'bikes#create'
      put   'bikes' => 'bikes#update'
    end
  end
end
