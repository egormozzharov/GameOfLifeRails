class UsersController < ApplicationController
  # before_action :set_user, :add_email, :except => [:index, :save_email]
  # before_action :set_user
  # before_filter :ensure_valid_email, :except => [:save_email, :add_email]

  def index
    @user = User.all
  end

  def user_details
     # binding.pry
    if @user = User.where(:id => params[:id]).first
       # binding.pry
        render :template => 'users/user_details'
    else
        render :template => 'users/user_not_found'
    end
  end

  def current_user_details
    @user = current_user
  end

  def add_email
    @user = current_user
    render
  end


  def save_email
    # binding.pry

    if params[:user] && params[:user][:email]
      current_user.email = params[:user][:email]
      current_user.skip_reconfirmation! # don't forget this if using Devise confirmable
      respond_to do |format|
        if current_user.save
          format.html { redirect_to home_index_path }
          format.json { head :no_content }
        else
          format.html { render :template => 'error', @show_errors => true }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
