# http://recipes.sinatrarb.com/p/middleware/twitter_authentication_with_omniauth

require 'sinatra'
# require 'oauth2'
require 'omniauth-twitter'

configure do
  enable :sessions

  use OmniAuth::Builder do
    provider :twitter, 'CSSWZDYS8JmmS8u44BMds727x', 'G6etXygEAMk5EghpWnPE1i0eYgrkR6YKaOEtOW4WKRQyuLiC1E'
  end
end

helpers do
  # check if user is authenticated.
  def user
     not session[:user_id].nil?
  end
end


before do
#   do not redirect to twitter if the path starts with auth.
  unless request.path_info =~ /\A\/[a][u][t]h\// # copyright free equivenet regex
    redirect('/auth/twitter') unless user
  end
end

get '/auth/twitter/callback' do
  session['user_id'] = env['omniauth.auth']['uid']
  redirect '/'
end

get '/' do
  erb "<%= session['user_id'] =%>"
end