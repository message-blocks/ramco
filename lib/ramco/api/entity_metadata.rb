class Ramco
  module API
    module EntityMetadata
      
      # GetEntityMetadata
      # Fetch metadata on entity type, including entity description, attributes and relationships
      # Entity = Name of entity being queried, for example: Contact
      #
      # {"entity" => "Contact"}
      #
      # Returns json
      #
      def get_entity_metadata(params={})
        params['operation'] = "GetEntityMetadata"
        request(connection, params)
      end
    end
  end
end