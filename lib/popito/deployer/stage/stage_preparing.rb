require 'fileutils'

module Popito
  class StagePreparing
    attr_accessor :config_payload

    def initialize(config_payload)
      self.config_payload = config_payload
    end

    def create_deployer_folder(stage:)
      config_payload.included_files = Popito::IncludedFiles.new(config_payload: config_payload).included_files_list
      Popito::ArchiveDownloading.new(config_payload: config_payload).download_and_extract(stage: stage)
      docker_ajusts if config_payload.stages.include?('build')
    end

    private

    def docker_ajusts
      return unless File.exist?("#{config_payload.build_path}/.dockerignore")

      File.open("#{config_payload.project_path}/.dockerignore", 'a') do |file|
        file.write File.read("#{config_payload.build_path}/.dockerignore")
      end
    end
  end
end
