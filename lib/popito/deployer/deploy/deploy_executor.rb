module Popito
  class DeployExecutor
    attr_accessor :config_payload

    def initialize(config_payload)
      self.config_payload = config_payload
      @deploy_files_dir = "#{config_payload.deploy_path}/deploy"
    end

    def check
      puts 'Validating generated files...'
      system "kubectl apply --validate=true --dry-run=client -f #{@deploy_files_dir}", exception: true
    end

    def deploy
      puts 'Applying generated files...'
      system "kubectl apply -f #{@deploy_files_dir}", exception: true
    end

    def push_deployed_tag
      yaml_build_config["build"].each do |build|
        tag = build["tags"].first
        puts "Pushing #{build["image"]}:#{tag} to #{build["image"]}:popito-#{config_payload.build_config[:ENVIRONMENT]}"
        system "docker image tag #{build["image"]}:#{tag} #{build["image"]}:popito-#{config_payload.build_config[:ENVIRONMENT]}", exception: true
        system "docker push #{build["image"]}:popito-#{config_payload.build_config['ENVIRONMENT']}", exception: true
      end
    end

    private
    
    def yaml_build_config
      @yaml_config ||= load_build_yaml
    end

    def load_build_yaml
      YAML.safe_load(File.read("#{config_payload.build_path}/build.yaml"))
    end
  end
end
