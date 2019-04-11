class Ramco
  module API
    module ClearCache

      # ClearCache
      # Clears the server-side metadata cache. If an entity or attribute has been added (or removed),
      # then clearing the cache will permit the changes to be reflected immediately. 
      # The cache will normally expire every 24 hours.
      #
      # Returns json
      #
      def clear_cache(params={})
        params['operation'] = "ClearCache"
        request(connection, params)
      end
    end
  end
end