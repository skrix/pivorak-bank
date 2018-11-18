require_relative '../lib/app/services/loader'
require 'pry'

CONFIG = './lib/app/database/config.yml'
DB     = YAML.load_file(CONFIG)
