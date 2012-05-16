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

    def slotlock(options)
      parse_uri_options(:restaurant_id, :date_time, :party_size, :time_security_id, :search_results_id, options)
      uri = "/slotlock/?pid=#{ENV['OT_PARTNER_ID']}&st=0&"
      response = @access_token.post(uri, {'RID' => @restaurant_id, 'datetime' => @date_time, 'partysize' => @party_size, 'timesecurityID' => @time_security_id, 'resultskey' => @search_results_id})
      parse_json(response.body)
    end
  end
end
