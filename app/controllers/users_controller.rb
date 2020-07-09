class UsersController < ApplicationController
   
    get '/signup' do
        if is_logged_in?
            # flash[:message] = "You were already logged in. Here are your reviews."
            redirect '/recipes'
        else
            erb :'/users/signup'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            # flash[:message] = "In order to sign up for account, you must have both a username & a password. Please try again."
            redirect '/signup'
        else
            user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
            session[:user_id] = user.id
            redirect '/recipes'
        end
    end 

    get '/login' do
        if is_logged_in?
            redirect '/recipes'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            # binding.pry
            redirect to '/recipes'
        else
            erb :'/users/login'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

end