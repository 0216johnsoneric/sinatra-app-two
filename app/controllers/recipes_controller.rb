require 'pry'

class RecipesController < ApplicationController

    get '/recipes' do
        if is_logged_in?
            @user = current_user
            @recipes = Recipe.all
            erb :'recipes/recipes'
        else
            redirect '/login'
        end
    end

    get '/recipes/new' do
        if is_logged_in?
            @user = current_user
            erb :'recipes/create_recipe'
        else
            redirect '/login'
        end
    end

    post '/recipes' do
        @user = current_user
        if !params[:content].empty?
            @recipe = Recipe.create(:name=>params[:name], :content=>params[:content], user: @user)
            @user.recipes << @recipe
            @user.save
            redirect to "/recipes"
        else
            redirect to 'recipes/new'
        end
    end

    get '/recipes/:id' do
        if is_logged_in?
            @user = current_user
            @recipe = Recipe.find_by_id(params[:id])
            erb :'/recipes/show_recipe'
        else
            redirect to '/login'
        end
    end

    get '/recipes/:id/edit' do
        @recipe = Recipe.find_by_id(params[:id])
        if is_logged_in? && @recipe.user_id == current_user.id
            erb :'/recipes/edit'
        else
            redirect 'login'
        end
    end

    patch '/recipes/:id/edit' do
        @recipe = Recipe.find_by_id(params[:id])
        @user = current_user
        if !params[:content].empty? 
            @recipe.update(:name => params[:name], :content => params[:content])
            @recipe.save
            redirect "recipes/#{@recipe[:id]}"
        else 
            redirect "recipes/#{@recipe[:id]}/edit"
        end
    end

    post '/recipes/:id/delete' do
        @recipe = Recipe.find_by_id(params[:id])
        if is_logged_in? && @recipe.user_id == current_user.id
            @recipe.delete
            redirect to '/recipes'
        else
            redirect to "/recipes/#{params[:id]}"
        end
    end
end