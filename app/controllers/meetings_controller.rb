class MeetingsController < ApplicationController
  def index
    response = { message: "Hello, World!" }
    render json: response
  end
end
