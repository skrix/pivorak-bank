# frozen_string_literal: true

CONFIG = 'config.yml'

require 'yaml'
require_relative 'system/presenter'
require_relative 'bank/bank_database'
require_relative 'bank/service'

config   = YAML.load_file(ARGV.first || CONFIG)
database = BankDatabase.new(config)
service  = Service.new(database)
runtime  = Presenter.new(service)
runtime.call
