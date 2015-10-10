class PresetsController < ApplicationController
    respond_to :html, :js

    def index
        @my_presets = Preset.all.where(:user_id => current_user.id)
        if params[:format]
            cookies[:conf_id] = params[:format]
        end
    end

    def all_presets
        @all_presets = Preset.all
    end

    def add_preset
        preset = Preset.find_by_id(params[:id])
        if preset
            newPreset = Preset.create(:desc => preset[:desc],:name => preset[:name], :user_id => current_user.id)

            # create all coordinates but with current preset_id
            # сначала достаем все координаты пресета,
            oldCoords = Coord.all.where(:preset_id => params[:id])

            oldCoords.each do |item|
                Coord.create(:x => item.x, :y => item.y, :preset_id => newPreset.id)
            end
            # binding.pry
            # а потом проходимся циклом и создаем новые координаты, с параметрами
            # такими же как у старых, но с новым preset_id

            redirect_to all_presets_path
        end
    end

    def new
        @new_preset = Preset.new
    end

    def create
        binding.pry
    end


    def test
        grid = params[:grid]
        config = params[:conf]
        c = Preset.create(:desc => params[:desc],:name => params[:name], :user_id => current_user.id)
        if c.valid?
            grid = params[:grid]
            if grid
                grid.each do |cell|
                    x = cell[1][:column]
                    y = cell[1][:row]
                    Coord.create(:x => x, :y => y, :preset_id => c.id)
                end
                @message = "Preset successfully added!"
                render 'preset_added'
            else
                @message = "You need to select cells!"
                render 'preset_warn'
            end
        else
                @message = c.errors.full_messages.to_sentence
                 render 'preset_warn'
        end

    end

    def destroy
        @preset = Preset.find(params[:id])
        @preset.destroy
        Coord.destroy_all(:preset_id => params[:id])
        # binding.pry
        respond_to do |format|
            format.html { redirect_to presets_path }
            format.json { head :no_content }
        end
    end
end
