class Ramco
  module API
    module EntityTypes
      
      # GetEntityTypes
      # Returns a complete list of all entities in the system
      #
      # Returns json
      #
      def get_entity_types(params={})
        params['operation'] = "GetEntityTypes"
        request(connection, params)
      end
    end
  end
end