# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.use Rack::Cors do
  allow do
    # TODO: CHANGE TO TRUSTABLE ORIGIN ONLY
    origins '*'

    resource '*',
             headers: :any,
             expose:  %w(access-token expiry token-type uid client Date),
             methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
