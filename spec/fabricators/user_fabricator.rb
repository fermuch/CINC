# -*- encoding : utf-8 -*-
Fabricator(:user) do
  name     'Test User'
  email    'example@example.com'
  password 'changeme'
  password_confirmation 'changeme'
  # required if the Devise Confirmable module is used
  # confirmed_at Time.now
end
