# frozen_string_literal: true

require 'yaml'
require './bank/presenter'

config = YAML.load_file(ARGV.first || 'config.yml')
runtime = Presenter.new(config)
runtime.call
