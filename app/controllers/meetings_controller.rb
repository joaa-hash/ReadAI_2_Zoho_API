class MeetingsController < ApplicationController
  def index
    response = { message: "Hello, World!" }
    render json: response
  end

  def new
    if params[:session_id].present?
      # Send data in params to ZOHO API
      # we response succesfully
      pust params
      render json: { message: "Meeting created successfully" }
    else
    response = { message: "We did not receive meeting data" }
    render json: response
    end
  end
end
