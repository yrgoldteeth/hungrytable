module Hungrytable
  class Restaurant < ::Hungrytable::Base
    def get_details(restaurant_id)
      uri = "/restaurant/?pid=#{ENV['OT_PARTNER_ID']}&rid=#{restaurant_id}"
      response = @access_token.get(uri)
      parse_json(response.body)
    end

    def search(options)
      parse_uri_options(:restaurant_id, :date_time, :party_size, options)
      uri = "/table/?pid=#{ENV['OT_PARTNER_ID']}&st=0&rid=#{@restaurant_id}&dt=#{@date_time}&ps=#{@party_size}"
      response = @access_token.get(uri)
      parse_json(response.body)
    end

    # MUST FIRST MAKE A CALL TO #search.
    def slotlock(options)
      parse_uri_options(
        :restaurant_id, 
        :date_time, 
        :party_size, 
        :time_security_id, 
        :search_results_id, 
        options
      )
      uri = "/slotlock/?pid=#{ENV['OT_PARTNER_ID']}&st=0"
      response = @access_token.post(uri, {
        'RID'            => @restaurant_id, 
        'datetime'       => @date_time, 
        'partysize'      => @party_size, 
        'timesecurityID' => @time_security_id, 
        'restultskey'    => @search_results_id
      })
      parse_json(response.body)
    end

    # MUST FIRST MAKE A CALL TO #slotlock
    def make_reservation(options)
      parse_uri_options(
        :restaurant_id, 
        :date_time, 
        :party_size, 
        :email_address, 
        :phone, 
        :firstname, 
        :lastname, 
        :slotlockid, 
        :time_security_id, 
        :search_results_id 
        options
      )
      uri = "/reservation/?pid=#{ENV['OT_PARTNER_ID']}&st=0"
      response = @access_token.post(uri, {
        'RID' => @restaurant_id,
        'email_address' => @email_address,
        'datetime' => @date_time,
        'partysize' => @party_size,
        'phone' => @phone,
        'firstname' => @firstname,
        'lastname' => @lastname,
        'timesecurityID' => @time_security_id,
        'restultskey' => @search_results_id,
        'slotlockid' => @slotlockid
      })
      parse_json(response.body)
    end

    # MUST FIRST HAVE MADE CALL TO #make_reservation
    # OMG it's a get request.
    def cancel_reservation(options)
      parse_uri_options(:reservation_id, :restaurant_id, :email)
      url = "/reservation/?pid=#{ENV['OT_PARTNER_ID']}&st=0&rid=#{@restaurant_id}&email=#{@email}&conf=#{@reservation_id}"
      response = @access_token.get(uri)
      parse_json(response.body)
    end

  end
end
