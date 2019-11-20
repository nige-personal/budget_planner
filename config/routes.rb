# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  unless Rails.env.production?
      get 'get_index', controller: :mock, action: :get_index
  end
end
