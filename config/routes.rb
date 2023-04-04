Rails.application.routes.draw do
  namespace :public do
    get 'members/index'
    get 'members/show'
    get 'members/edit'
  end
  # namespaceにすることでURLにadminを含む
  namespace :admin do
    root to: 'homes#top'
    resources :members, only: [:index, :show, :edit, :update]
    resources :posts,   only: [:index, :show, :edit, :update]
  end
  # scopeにすることでURLにpublicを含まない
  scope module: :public do
    root to: 'homes#top'
    resources :posts
    resources :chats,   only: [:create, :show]
    # relationshipsはmemberモデルにネストする
    resources :members, only: [:index, :show, :edit] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    get 'homes/about'
  end

  # 顧客用
  # URL /members/sign_in ...
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
