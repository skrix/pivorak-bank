# frozen_string_literal: true

COMPONENTS = %w[
  ../concern/callable
  ../models/account
  ../models/database
  ../models/user
  ../models/transaction
  ../models/transactions/deposit
  ../models/transactions/withdrawal
  ../models/transactions/transfer
  ../modules/errors_out
  ../modules/questions
  ../system/io_handler
  ../system/presenter
  ./transactions_performer
  ./paydesk
].freeze

GEMS = %w[
  smart_init
  yaml
].freeze

GEMS.each { |gem| require gem }

COMPONENTS.each { |component| require_relative component }
