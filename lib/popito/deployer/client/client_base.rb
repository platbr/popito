require 'rest-client'
require 'json'
require 'minitar'
module Popito
  class ClientBase
    API_HOST = 'http://localhost:3000'.freeze
    attr_accessor :config_payload

    def initialize(config_payload:)
      self.config_payload = config_payload
    end

    private

    def parse_error(err)
      JSON.parse(err.response.body)["message"]
    rescue StandardError
      "An error has been occurred."
    end

    def extract_tgz(body)
      Minitar.unpack(Zlib::GzipReader.new(StringIO.new(body)), config_payload.project_path)
    end

    def default_headers
      { 'X-Client-Version': Popito::VERSION, 'X-Project-Token': config_payload.project_token }
    end
  end
end
