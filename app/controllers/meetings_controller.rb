class MeetingsController < ApplicationController
  include HTTParty
  def initialize
    @zoho_client_id = ENV["ZOHO_CLIENT_ID"]
    @zoho_client_secret = ENV["ZOHO_CLIENT_SECRET"]
    # refresh token does not expire, it is used to get a new access token
    @refresh_token = ENV["ZOHO_REFRESH_TOKEN"]
    # acces_token is valid for 1 hour
    @access_token = nil
    @expires_in = Time.now
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
      start_time = format_datetime(params[:start_time])
      end_time = format_datetime(params[:end_time])
      summary = params[:summary]
      report_url = params[:report_url]
      puts "Session ID: #{session_id}"
      puts "Title: #{title}"
      puts "Start Time: #{start_time}"
      puts "End Time: #{end_time}"
      puts "Summary: #{summary}"
      puts "Report URL: #{report_url}"

      if @access_token.nil? || Time.now > @expires_in
        refresh_access_token
      end
      if @access_token.present?
        submit_to_zoho_crm(params)
      else
        response = { message: "Failed to get access token" }
        render json: response
      end
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
        "Authorization" => "Zoho-oauthtoken #{@access_token}",
        "Content-Type" => "application/json"
      },
      body: {
        data: [
          {
            Name: params[:title],
            session_id: params[:session_id],
            summary: params[:summary],
            action_items: params[:action_items],
            report_url: params[:report_url],
            start_time: params[:start_time],
            end_time: params[:end_time]
          }
        ]

      }.to_json
    }
    # Sending the POST request
    meetings_url = "https://www.zohoapis.com/crm/v2/Read_AI_meetings"
    response = HTTParty.post(meetings_url, options)
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

  def refresh_access_token
    puts "Refreshing the access token"
    auth_uri = "https://accounts.zoho.com/oauth/v2/token"
    options = {
      headers: {
        "Content-Type" => "application/x-www-form-urlencoded"
      },
      body: {
        client_id: @zoho_client_id,
        client_secret: @zoho_client_secret,
        refresh_token: @refresh_token,
        grant_type: "refresh_token"
      }
    }
    response = HTTParty.post(auth_uri, options)
    if response.success?
      json_data = response.parsed_response
      @access_token = json_data["access_token"]
      @expires_in = Time.now + json_data["expires_in"]
      puts "Access Token updated"
      puts "Access Token expires in: #{@expires_in}"
    else
      puts "Failed to refresh the access token"
      puts "Error came from Zoho: #{response.code}"
    end
  end

  def get_access_token
    # Get access token is intended to get access and refresh token
    # for the first time, it requires a code generated from the Zoho
    # authorization page
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
      puts "Error came from Zoho: #{response.code} - #{response.message}"
      nil
    end
  end

  def format_datetime(datetime_str)
    puts "input datetime: #{datetime_str}"
    # Parse the datetime string to a DateTime object
    datetime = DateTime.parse(datetime_str)
    # Format the DateTime object to the ISO8601 format
    # as required by Zoho CRM
    formatted = datetime.iso8601
    puts "formatted datetime: #{formatted}"
    formatted
  end
end
