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
  end
end
