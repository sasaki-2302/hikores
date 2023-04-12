Rails.application.routes.draw do
  # ユーザー用
  # URL /members/sign_in ...
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :member do
    post 'member/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm

  get 'search' => 'searchs#search', as: 'search'
  # namespaceにすることでURLにadminを含む
  namespace :admin do
    root to: 'homes#top'
    resources :members, only: [:index, :edit, :update]
  end
  # scopeにすることでURLにpublicを含まない
  scope module: :public do
    root to: 'homes#top'
    resources   :posts,     except: [:new] do
      resources :comments,  only: [:create, :destroy]
      resource  :favorites, only: [:create, :destroy]
    end
    # relationshipsはmemberモデルにネストする
    resources  :members,       only: [:index, :show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers'  => 'relationships#followers',  as: 'followers'
      put 'hide' => 'members#hide', as: 'hide'
      # member do はURLに:idを含む / collection doは含まない
      member do
       get :favorites
      end
    end
    resources :chats, only: [:create, :show]
    get 'about' => 'homes#about', as: 'about'
  end
end
