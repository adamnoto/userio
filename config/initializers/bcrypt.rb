if Rails.env.test?
  BCrypt::Engine.cost = 2
else
  BCrypt::Engine.cost = 11
end
