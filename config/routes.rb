Rails.application.routes.draw do
  root controller: :calculators, action: :new

  resource :calculators, only: [:new] do
    get :calculate, on: :collection
  end
end
