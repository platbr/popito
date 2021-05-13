require 'rest-client'
require 'json'
require 'minitar'
module Popito
  class IncludedFiles < Popito::ClientBase
    def included_files_list
      response = RestClient.get("#{API_HOST}/api/v1/included-files", headers = default_headers)
      JSON.parse(response.body)
    rescue RestClient::UnprocessableEntity => e
      raise parse_error(e)
    end
  end
end
