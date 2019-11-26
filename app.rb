require 'sinatra'
require 'oauth2'

require 'omniauth-twitter'

configure do
  enable :sessions

  use OmniAuth::Builder do
    provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
  end
end