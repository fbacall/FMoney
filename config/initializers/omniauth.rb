Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, Rails.application.credentials.github[:key], Rails.application.credentials.github[:secret]
end
