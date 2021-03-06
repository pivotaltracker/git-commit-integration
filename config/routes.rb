Rails.application.routes.draw do
  get 'fake_sha', to: 'fake_sha#show'
  get 'github/authorize'
  get 'users/auth/github/callback/auth_app_callback', to: 'github#auth_app_callback'

  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks',
    }

  devise_scope :user do
    get 'sign_in', to: redirect('/users/auth/github'), as: :new_user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  authenticate :user do
    resources :repos do
      resources :pushes do
        resources :commits, shallow: true
      end
      resources :commits, only: [:index]
      resources :refs, shallow: true
    end
    resources :refs, only: [] do
      resources :commits, only: [:index]
    end
    resources :commits, only: [] do
      resources :external_links, only: [:index]
      resources :pushes, only: [:index]
      resources :refs, only: [:index]
      resources :parent_commits, except: [:edit, :new]
    end

    resources :external_links do
      resources :commits, only: [:index]
    end

    resources :external_link_commits, as: 'elcs'

    resources :external_link_repos

    resources :deploy_repos

    resources :github_users

    get 'repos/:id/create_hook', to: 'repos#create_hook', as: :repo_create_hook

    get 'reports/external_link_ref_commits'
    get 'reports/deploy_external_link_ref_commits'

    resources :deploys
    resources :deploy_commits
  end

  # unsecure and unauthencated actions:
  post 'repos/:repo_id/pushes/receive', to: 'pushes#receive'
  root 'home#show'
end
