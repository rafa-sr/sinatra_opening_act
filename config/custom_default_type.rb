# frozen_string_literal: true

module Config
  class CustomDefaultType
    def initialize(app)
      @app = app
    end

    def call(env)
      # since curl set by default add content-type with
      # application/x-www-form-urlencode i'm not able to ask is nil or
      # use Rack::ContentType, "application/json", so by now
      # this will be only a json api, so by now we accept just json

      env['CONTENT_TYPE'] = 'application/json'
      @app.call(env)
    end
  end
end
