class Ramco
  module API
    module Entity

      # GetEntity
      # Fetch the attributes and/or relationships of one specific entity using guid.
      #
      # Entity = Type of entity being queried (ex: Contact)
      # Guid = guid of entity to return
      # Attributes = comma separated list of attributes to return
      #
      # {"entity" => "Contact", "guid" => "6868642f-0144-e811-9c17-00155d10120d", "attributes" => "ContactId,FirstName,LastName"}
      #
      # Returns json
      #
      def get_entity(params={})
        params['operation'] = "GetEntity"
        request(connection, params)
      end
    end
  end
end