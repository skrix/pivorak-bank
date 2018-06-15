# frozen_string_literal: true

require 'yaml'

config = YAML.load_file(ARGV.first || 'config.yml')

runtime = Presenter.new(config)
