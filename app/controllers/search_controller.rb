class SearchController < ApplicationController
    before_action :authenticate_user!

    def index

        @rule_results = Conf.search(params[:query])
        @grid_results = Preset.search(params[:query])
        respond_to do |format|
            format.js {render 'respond_to_search'}
            format.html
        end
    end

    def rebuild_indexes
        %x[rake ts:rebuild]
        respond_to do |format|
            @message = "Indexes succsessfully rebuilt"
            format.js {render 'respond_to_rebuild'}
        end
    end

end
