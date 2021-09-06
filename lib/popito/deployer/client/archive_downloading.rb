require 'rest-client'
require 'json'
require 'minitar'
module Popito
  class ArchiveDownloading < Popito::ClientBase
    def download_and_extract(stage:)
      payload = { stage: stage, build_config: config_payload.build_config,
                  included_files: config_payload.included_files_payload }
      response = RestClient.post("#{config_payload.api_endpoint}/api/v1/archive", payload, headers = default_headers)
      extract_tgz(response.body)
    rescue RestClient::UnprocessableEntity => e
      raise parse_error(e)
    end
  end
end
