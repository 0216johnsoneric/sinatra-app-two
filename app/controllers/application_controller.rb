require './config/environment'
# require 'sinatra/flash'
class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "password_secret"
    end

    get '/' do
        erb :index
    end

    helpers do

        def is_logged_in?
            !!session[:user_id]
        end

        def current_user
            @user = User.find(session[:user_id])
        end
    end
end