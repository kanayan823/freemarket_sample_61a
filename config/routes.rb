Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'telephones', to: 'users/registrations#new_telephone' # 電話番号を登録させるページを表示するアクション
    post 'telephones', to: 'users/registrations#create_telephone' # 電話番号を登録するアクション
    get 'addresses', to: 'users/registrations#new_address' # 住所を登録させるページを表示するアクション
    post 'addresses', to: 'users/registrations#create_address' # 電話番号を登録するアクション
    get 'cards', to: 'users/registrations#new_card' # クレジットカード情報の登録させるページを表示するアクション
    post 'cards', to: 'users/registrations#create_card' # クレジットカードを登録するアクション
  end
  root "items#index"

  resources :users, only: [:index] do 
    collection do
      get :login
    end
  end
  resources :users, only: [:listing, :in_progress, :completed], path: '/mypage/listings' do
    collection do
      get 'listing'
      get 'in_progress'
      get 'completed'
    end
  end
  resources :items, only: [:index, :new, :create, :show, :destroy, :edit, :update] do
    #Ajaxで動くアクションのルートを作成
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  resource :items, only: :confirmation, path: ":id" do
    collection do
      get 'confirmation'
      get 'complete'
    end
  end
  resource :items, only: :show_mine, path: ":id" do
    collection do
      get 'show_mine'
      get 'item_stop'
      get 'item_state'
      get 'item_buy'
    end
  end
  resources :mypages, only: [:index] do
    collection do
      get 'identification'
      get :profile
      get :card
      get :card_create
      get :logout
    end
  end
  resources :categories, only: [:index, :show]
end