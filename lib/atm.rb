# frozen_string_literal: true

CONFIG = 'config.yml'

require 'yaml'
require './bank/presenter'

config = YAML.load_file(ARGV.first || CONFIG)
runtime = Presenter.new(config)
runtime.call
