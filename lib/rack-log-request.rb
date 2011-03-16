require 'mongo'
module Rack
  class LogRequest

    ##
    # Intialize the LogRequest Middleware.
    #
    # @params[Rack] app the Rack application
    # @params[Hash] options all options about this middleware
    # @opts[String] mongo_db a Mongo::Database object
    # @opts[String] host the host of your MongoDB database
    # @opts[String] port the port of your MongoDB database
    # @opts[String] database the database of your MongoDB database
    # @opts[String] user the user to access your MongoDB database
    # @opts[String] password the password of your MongoDB user to access database
    #
    def initialize(app, options = {})
      @app = app
      unless options.has_key?(:mongo_db)
        @mongo_connection =  Mongo::Connection.new(options[:host], options[:port], :timeout => 5)
        if options.has_key?(:user)
          @mongo_connection.add_auth(options[:database], options[:user], options[:password])
        end
        @mongo_database = @mongo_connection.db(options[:database])
      else
        @mongo_database = options[:mongo_db]
      end
      @mongo_collection = @mongo_database.collection('rack-log-request')
    end

    def call(env)
      t = Time.now
      status, headers, response = @app.call(env)
      @mongo_collection.insert({:request => env['REQUEST_URI'],
                                :status => status,
                                :size => response.body.size,
                                :millis => (Time.now - t)*1000})
      return [status, headers, response]
    end

  end
end
