Knowledge::Application.routes.draw do
  resources :users do
    collection do
      get :search, to: :search, as: :search
    end
  end

  resources :groups do
    member do
      post :add_user, to: :add_user, as: :add_user
      delete :del_user, to: :del_user, as: :del_user
    end
  end

  resources :file_categories, except: [:show], shallow: true do
    resources :files, except: [:new, :edit, :update]
  end

  resources :board_categories, except: [:show], shallow: true do
    resources :boards do
      member do
        post :comments, to: :comment, as: :comment
        delete "comments/:comment_id", to: :uncomment, as: :uncomment
      end
    end
  end

  resources :qa_categories, shallow: true do
    member do
      post :add_user, to: :add_user, as: :add_user
      delete :del_user, to: :del_user, as: :del_user
    end

    resources :questions do
      member do
        post :answers, to: :answer, as: :answer
        delete "answers/:answer_id", to: :unanswered, as: :unanswered
      end
    end
  end
  
  controller :users do
    get :home, to: :home, as: :home
    get :profile, to: :profile, as: :profile
    patch :profile, to: :update_profile, as: :update_profile
    patch :password, to: :update_password, as: :update_password
  end

  controller :sessions do
    get :signin, to: :new, as: :signin
    post :signin, to: :create, as: :session_create
    get :signout, to: :destroy, as: :signout
  end

  controller :root do
    root to: :index
  end
end
