require_relative './builders/docker'
require 'yaml'

module Popito
  class BuildExecutor
    attr_accessor :config_payload

    def initialize(config_payload)
      self.config_payload = config_payload
    end

    def yaml_config
      @yaml_config ||= load_yaml
    end

    def build
      yaml_config["build"].each do |build|
        build["tags"].each do |tag|
          builder = Popito::BuildExecutor::Builders::Docker.new(
            root_path: config_payload.project_path,
            dockerfile: "#{config_payload.build_path}/#{build['dockerfile']}",
            image: build["image"],
            tag: tag
          )
          builder.build
        end
      end
    end

    def release
      yaml_config["build"].each do |build|
        build["tags"].each do |tag|
          builder = Popito::BuildExecutor::Builders::Docker.new(
            root_path: config_payload.project_path,
            dockerfile: "#{config_payload.build_path}/#{build['dockerfile']}",
            image: build["image"],
            tag: tag
          )
          builder.push
        end
      end
    end

    private

    def camelize(value)
      value.to_s.capitalize.gsub(/_(\w)/) { Regexp.last_match(1).upcase }
    end

    def load_yaml
      YAML.safe_load(File.read("#{config_payload.build_path}/build.yaml"))
    end
  end
end
