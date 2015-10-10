class ConfsController < ApplicationController
    before_action :authenticate_user!

    def index
        # binding.pry
        @my_configs = Conf.all.where(:user_id => current_user.id)
    end

    def all_confs
        @all_configs = Conf.all
    end

    def add_conf
        conf = Conf.find_by_id(params[:id])
        if conf
          Conf.create(:desc => conf[:desc],:name => conf[:name], :alive => conf[:alive],
                        :die => conf[:die], :user_id => current_user.id)
          flash[:notice] = 'config_has_been_added'
          redirect_to confs_all_confs_path

        end
    end


    def create
        rule = params[:conf]
        turn_on = String.new("000000000")
        turn_off = String.new("000000000")
        9.times do |i|
            turn_on[i] = '1' if params["alive_#{i}"]
        end
        9.times do |i|
            turn_off[i] = '1' if params["die_#{i}"]
        end
        config = params[:conf]
        c = Conf.create(:desc => config[:desc],:name => config[:name], :alive => turn_on,
                        :die => turn_off, :user_id => current_user.id)
        if c.valid?
            redirect_to confs_path
        else
            flash[:alert] = c.errors.full_messages.to_sentence
            redirect_to new_conf_path
        end
    end


    def destroy
        @config = Conf.find(params[:id])
        @config.destroy
        respond_to do |format|
            format.html { redirect_to confs_path }
            format.json { head :no_content }
        end
    end


    def new
        @new_config = Conf.new
    end

    private






end
