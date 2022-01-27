module JsonPresenterHelper

    def render_response(response)
        render json: response
    end
end

