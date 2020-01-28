Rails.application.routes.draw do

  # Main Static Pages
  root 'main#landing'
  get 'about' => 'main#about', as: :about
  get 'help' => 'main#help', as: :help
  get 'debug' => 'main#debug', as: :debug

  # User Authentications
  resources :sessions, only: [:new, :create, :destroy]
  get 'register' => 'users#new', as: :signup
  get 'login'=> 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout

  # Change Enum Values
  get 'complete' => 'courses#complete', as: :complete
  get 'ongoing' => 'courses#ongoing', as: :ongoing
  get 'approve' => 'applications#approve', as: :approve
  get 'deny' => 'applications#deny', as: :deny
  get 'pending' => 'applications#pending', as: :pending

  # Restful Routes
  resources :users
  resources :universities
  resources :qualifications
  resources :courses
  resources :applications
  resources :papers

end
