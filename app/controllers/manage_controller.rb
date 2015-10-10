class ManageController < ApplicationController
    before_filter :checkRights

    def index
        @users = User.all
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        respond_to do |format|
            format.html { redirect_to manage_index_url }
            format.json { head :no_content }
        end
    end

    def make_role
        @user = User.find(params[:id])
        role = params[:role]
        if role == 'admin'
            binding.pry
            @user.isAdmin = false
            @user.save
        else
            if role == 'user'
                binding.pry
                @user.isAdmin = true
                @user.save
            end
        end
        redirect_to manage_index_path
    end

    private

    def checkRights
        if user_signed_in? && current_user.isAdmin

        else
            redirect_to home_index_path
        end
    end
end
