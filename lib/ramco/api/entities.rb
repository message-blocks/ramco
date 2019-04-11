class Ramco
  module API
    module Entities
      
      # Get entities
      # Fetch the attributes and/or relationships of multiple entities of one type using a user-defined filter.
      #
      # Entity = Name of entity being queried (ex: Contact)
      # Filter (optional) = User-specified filter string
      # Attributes = comma separated list of attributes to return
      # StringDelimiter (optional) = User-specified delimiter used to wrap string values (default is #)
      # MaxResults (optional) = Maximum number of entities to return
      #
      # {"entity" => "Contact", "attributes" => "ContactId,FirstName,LastName", "maxresults" => "5"}
      #
      # Returns json
      #
      def get_entities(params={})
        params['operation'] = "GetEntities"
        request(connection, params)
      end
    end
  end
end