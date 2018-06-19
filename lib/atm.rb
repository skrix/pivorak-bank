# frozen_string_literal: true

CONFIG = 'config.yml'

require 'yaml'
require './system/presenter'
require './bank/bank_database'
require './bank/service'

config   = YAML.load_file(ARGV.first || CONFIG)
database = BankDatabase.new(config)
service  = Service.new(database)
runtime  = Presenter.new(service)
runtime.call
