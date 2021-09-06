# frozen_string_literal: true

module Popito
  BUILD_DIR_NAME = '_popito/build'
  DEPLOY_DIR_NAME = '_popito/deploy'
end

require_relative "version"
require_relative 'config/config_payload'
require_relative 'client/client_base'
require_relative 'client/included_files'
require_relative 'client/archive_downloading'
require_relative 'stage/stage_preparing'
require_relative 'build/build_executor'
require_relative 'deploy/deploy_executor'
