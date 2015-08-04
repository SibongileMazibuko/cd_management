class WelcomeController < ApplicationController
  
  def welcome_index
    if request.post?
      username = params[:query][:username]
      password = params[:query][:password]
      user_exists = User.where("username =? AND password =?", username, password).first
      if user_exists
        redirect_to home_index_path(user_exists.id), notice: "Welcome to ... #{user_exists.first_name} #{user_exists.last_name}"
      elsif !user_exists
        return flash[:error] = "Either your username/pasword is incorrect. Please try again or sign-up if you're a new user!"
      end
    end       
  end
  
  def sign_up
    if request.post?
      @first_name = params[:query][:first_name]
      @last_name = params[:query][:last_name]
      @email = params[:query][:email]
      @username = params[:query][:username]
      @password = params[:query][:password]
      @password2 = params[:query][:password2]      
      error = validate
      return flash[:error]= error if !error.blank? && error != nil
      save_user        
    end
  end
  
  def validate
    return msg = "Please enter First Name" if @first_name.blank?
    return msg = "Please enter Last Name" if @last_name.blank?
    return msg = "Please enter Email" if @email.blank?
    return msg = "Please enter Username" if @username.blank?
    return msg = "Please enter Password" if @password.blank?
    return msg = "The entered Passwords don't match" if @password != @password2
  end
  
  def save_user
    User.create(
    first_name: @first_name,
    last_name: @last_name,
    email: @email,
    username: @username,
    password: @password)
    
    redirect_to welcome_index_path(@username), notice: "You have succesfully registered with..."
  end
end
