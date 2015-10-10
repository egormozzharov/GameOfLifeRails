
class GameController < ApplicationController
    before_action :authenticate_user!


  def index
      @conf = Conf.find_by_id(cookies[:conf_id])
      @coordinates = Coord.all.where(:preset_id => params[:id])
      if @conf == nil
          flash[:message] = t('no_rule')
          render 'first'
      end
  end


end
