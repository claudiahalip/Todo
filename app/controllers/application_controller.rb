class ApplicationController < ActionController::Base

    include JsonPresenterHelper
    skip_before_action :verify_authenticity_token
end
