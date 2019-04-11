class Ramco
  module API
    module ValidateUser
      
      # ValidateUser
      # Returns the globally unique id of a contact that matches the provided 
      # cobalt_username and cobalt_password parameters. 
      # 
      # Returns a 422 error when there is no user with provided username/password combination.
      #
      # cobalt_username = User's username
      # cobalt_password = User's password
      #
      # {"cobalt_username" => "username", "cobalt_password" => "password"}
      #
      # Returns json
      #
      def validate_user(params={})
        params['operation'] = "ValidateUser"
        request(connection, params)
      end
    end
  end
end