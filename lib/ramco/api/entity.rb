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
    
      # CreateEntity
      # Allows for creation of a new entity record.
      #
      # Entity = Type of entity being modified (ex: Contact)
      # AttributeValues = Comma separated attribute=value pairs.
      # StringDelimiter (optional) = User-specified delimiter used to wrap string values (default is #)
      #
      # {"entity" => "Contact", "attribute_values" => "FirstName=#Jane#,Birthday=1980-12-31,EmailVerified=true,NumChildren=3"}
      #
      # Returns json
      #
      def create_entity(params={})
        params['operation'] = "CreateEntity"
        request(connection, params)
      end

      # UpdateEntity
      # Allows for modification of attributes of existing Entities.
      #
      # Entity = Type of entity being modified (ex: Contact)
      # Guid = guid of entity being modified
      # AttributeValues = Comma separated attribute=value pairs.
      # StringDelimiter (optional) = User-specified delimiter used to wrap string values (default is #)
      #
      # {"entity" => "Contact", "attribute_values" => "FirstName=#Jane#,Birthday=1980-12-31,EmailVerified=true,NumChildren=3"}
      #
      # Returns json
      #
      def update_entity(params={})
        params['operation'] = "UpdateEntity"
        request(connection, params)
      end
    end
  end
end