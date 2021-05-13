require 'erb'
module Popito
  class BuildExecutor
    module Builders
      class Docker
        attr_accessor :dockerfile, :image, :tag, :root_path

        def initialize(root_path:, dockerfile:, image:, tag:)
          self.dockerfile = dockerfile
          self.image = image
          self.tag = tag
          self.root_path = root_path
        end

        def build
          puts "Building ..."
          puts "Dockerfile: #{dockerfile}"
          puts "Image: #{image}"
          puts "Tag: #{tag}"
          Dir.chdir(root_path)
          docker_build
        end

        def push
          puts "Pushing ..."
          puts "Dockerfile: #{dockerfile}"
          puts "Image: #{image}"
          puts "Tag: #{tag}"
          docker_push
        end

        private

        def docker_push
          puts "#{self.class.name}: docker push #{image_full_name}"
          system "docker push #{image_full_name}", exception: true
        end

        def docker_build
          puts "#{self.class.name}: docker build #{image_full_name}"
          system "docker build -f #{dockerfile} --tag #{image_full_name} .", exception: true
        end

        def image_full_name
          "#{image}:#{tag}"
        end
      end
    end
  end
end
