class MeetingsController < ApplicationController
  include HTTParty
  base_uri "https://www.zohoapis.com/crm/v2"
  def initialize
    @zoho_client_id = ENV["ZOHO_CLIENT_ID"]
    @zoho_client_secret = ENV["ZOHO_CLIENT_SECRET"]
    @zoho_auth_code = ENV["ZOHO_AUTH_CODE"]

    # store the access token in the session
    @access_token
    @refersh_token
    @expires_in

    get_access_token
  end
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

  def get_access_token
    # Prepare the request options
    auth_uri = "https://accounts.zoho.com/oauth/v2/token"
    options = {
      headers: {
        "Content-Type" => "multipart/form-data"
      },
      body: {
        client_id: @zoho_client_id,
        client_secret: @zoho_client_secret,
        code: @zoho_auth_code,
        redirect_uri: "",
        grant_type: "authorization_code"
      }
    }
    # Sending the POST request
    response = HTTParty.post(auth_uri, options)
    if response.success?
      json_data = response.parsed_response
      @access_token = json_data["access_token"]
      @refresh_token = json_data["refresh_token"]
      @expires_in = json_data["expires_in"]
      puts "Access Token: #{@access_token}"
      puts "Refresh Token: #{@refresh_token}"
      puts "Expires In: #{@expires_in}"
      json_data
    else
      pust "Error: #{response.code} - #{response.body}"
      nil
    end
  end
end
