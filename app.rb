# http://recipes.sinatrarb.com/p/middleware/twitter_authentication_with_omniauth

require 'sinatra'
# require 'oauth2'
require 'omniauth-twitter'
require 'omniauth-facebook'
configure do
  enable :sessions

  use OmniAuth::Builder do
    provider :twitter, 'CSSWZDYS8JmmS8u44BMds727x', 'G6etXygEAMk5EghpWnPE1i0eYgrkR6YKaOEtOW4WKRQyuLiC1E'
    # https://github.com/mkdynamic/omniauth-facebook
    provider :facebook, '2587047431403245' , 'bc33a5fe08047af8d471805b3602b75d',
             callback_url: 'https://sinatra-starter.herokuapp.com/auth/facebook/callback'
  end
end

helpers do
  # check if user is authenticated.
  def twitter_logged_in?
      # if a session is not found return false. return true otherwise.
      return session[:twitter_id].nil? ? false : true
  end
  def twitter_logged_in?
      # if a session is not found return false. return true otherwise.
      return session[:facebook_id].nil? ? false : true
  end
end


# before do
#   do not redirect to twitter if the path starts with auth.
#   unless request.path_info =~ /\A\/[a][u][t]h\// # copyright free equivenet regex
#     redirect('/auth/twitter') unless user_logged_in?
#   end
# end

get '/auth/twitter/callback' do
  session['twitter_id'] = env['omniauth.auth']['uid']
  # session['omniauth'] = env['omniauth.auth'] # the session is too big with this!
  redirect '/'
end

get '/auth/facebook/callback' do
  session['facebook_id'] = env['omniauth.auth']['uid']
  # session['omniauth'] = env['omniauth.auth'] # the session is too big with this!
  redirect '/'
end

get '/' do
  erb :login
end