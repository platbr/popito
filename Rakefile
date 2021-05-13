# frozen_string_literal: true

require "bundler/gem_tasks"

Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end

def remove_task(task_name)
  Rake.application.remove_task(task_name)
end

remove_task :release
task :release do
  spec = Gem::Specification.load(Dir.glob("*.gemspec").first)
  unless system "gem inabox pkg/#{spec.name}-#{spec.version}.gem --host #{ENV['GEM_SERVER_PUBLISH_URL']}"
    raise StandardError, "Falha ao executar task \"release\"."
  end
end

task :force_release do
  spec = Gem::Specification.load(Dir.glob("*.gemspec").first)
  unless system "gem inabox pkg/#{spec.name}-#{spec.version}.gem -o --host #{ENV['GEM_SERVER_PUBLISH_URL']}"
    raise StandardError, "Falha ao executar task \"release\"."
  end
end
