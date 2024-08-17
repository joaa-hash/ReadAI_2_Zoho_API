class MeetingsController < ApplicationController
  def index
    response = { message: "Hello, World!" }
    render json: response
  end

  def new
    if params[:session_id].present?
      # we get session_id, sumary, report_url, start_time, end_time and title
      session_id = params[:session_id]
      title = params[:title]
      start_time = params[:start_time]
      end_time = params[:end_time]
      summary = params[:summary]
      action_items = params[:action_items]
      report_url = params[:report_url]
      puts "Session ID: #{session_id}"
      puts "Title: #{title}"
      puts "Start Time: #{start_time}"
      puts "End Time: #{end_time}"
      puts "Summary: #{summary}"
      puts "Report URL: #{report_url}"

      render json: { message: "Meeting created successfully" }
    else
    response = { message: "We did not receive meeting data" }
    render json: response
    end
  end
end
