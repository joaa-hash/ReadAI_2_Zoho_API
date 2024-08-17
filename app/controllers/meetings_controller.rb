class MeetingsController < ApplicationController
  include HTTParty
  base_uri "https://www.zohoapis.com/crm/v2"

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
      report_url = params[:report_url]
      puts "Session ID: #{session_id}"
      puts "Title: #{title}"
      puts "Start Time: #{start_time}"
      puts "End Time: #{end_time}"
      puts "Summary: #{summary}"
      puts "Report URL: #{report_url}"

      submit_to_zoho_crm(params)
    else
      response = { message: "We did not receive meeting data" }
      render json: response
    end
  end

  private

  def submit_to_zoho_crm(params)
    # Prepare the request options
    options = {
      headers: {
        "Authorization" => "Zoho-oauthtoken #{ENV['ZOHO_ACCESS_TOKEN']}",
        "Content-Type" => "application/json"
      },
      body: {
        session_id: params[:session_id],
        summary: params[:summary],
        action_items: params[:action_items],
        report_url: params[:report_url]
      }.to_json
    }
    # Sending the POST request
    response = self.class.post("/meetings", options)
    puts response

    # Handling the response
    if response.success?
      puts "Meeting created successfully in Zoho CRM"
      render json: { message: "Meeting created successfully in Zoho CRM", zoho_response: response.parsed_response }
    else
      puts "Failed to create meeting in Zoho CRM"
      render json: { message: "Failed to create meeting in Zoho CRM", error: response.body }, status: :bad_request
    end
  end
end
