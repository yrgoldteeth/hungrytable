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
  end
end
