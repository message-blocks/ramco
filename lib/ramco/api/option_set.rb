class Ramco
  module API
    module OptionSet

      # GetOptionSet
      # Fetch the valid value/label pairs for the specified OptionSet (what Ramco calls a picklist)
      #
      # Entity = Name of entity being queried (ex: Contact)
      # Attribute = Name of the attribute being queried (ex: PreferredPhone)
      #
      # {"entity" => "Contact", "attribute" => "PreferredPhone"}
      #
      # Returns json
      #
      def get_option_set(params={})
        params['operation'] = "GetOptionSet"
        request(connection, params)
      end
    end
  end
end