require 'erb'
module Popito
  class BuildExecutor
    module Builders
      class Docker
        attr_accessor :dockerfile, :image, :tags, :root_path

        def initialize(root_path:, dockerfile:, image:, tags:)
          self.dockerfile = dockerfile
          self.image = image
          self.tags = tags
          self.root_path = root_path
        end

        def build
          puts "Building ..."
          puts "Dockerfile: #{dockerfile}"
          puts "Image: #{image}"
          puts "Tags: #{tags}"
          Dir.chdir(root_path)
          docker_build
        end

        def push
          puts "Pushing ..."
          puts "Dockerfile: #{dockerfile}"
          puts "Image: #{image}"
          puts "Tags: #{tags}"
          docker_push
        end

        private

        def docker_push
          tags.each do |tag|
            puts "#{self.class.name}: docker push #{image}:#{tag}"
            system "docker push #{image}:#{tag}", exception: true
          end
        end

        def docker_build
          command = "docker build -f #{dockerfile}"
          tags.each do |tag|
            command << " --tag #{image}:#{tag}"
          end
          command << " ."
          puts "#{self.class.name}: #{command}"
          system command, exception: true
        end
      end
    end
  end
end
