require 'base64'
module Popito
  class ConfigPayload
    attr_accessor :project_path, :build_path, :deploy_path, :stages, :build_config, :project_token, :included_files, :api_endpoint

    def initialize(project_path:, project_token:, stages: [], build_config: {}, included_files: [], api_endpoint: 'http://localhost:3000')
      self.project_path = File.expand_path(project_path)
      self.build_path = File.expand_path("#{project_path}/#{Popito::BUILD_DIR_NAME}")
      self.deploy_path = File.expand_path("#{project_path}/#{Popito::DEPLOY_DIR_NAME}")
      self.stages = stages
      self.project_token = project_token
      self.build_config = build_config
      self.included_files = included_files
      self.api_endpoint = api_endpoint
    end

    def included_files_payload
      included_files.map do |file|
        { encoding: 'base64', path: file, content: Base64.encode64(File.read("#{project_path}/#{file}")) }
      end
    end
  end
end
