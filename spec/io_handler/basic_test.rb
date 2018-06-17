# frozen_string_literal: true

require 'yaml'
require './lib/system/io_handler'

describe InputOutputHandler do
  let!(:str) { "Any input by 'bank' user" }

  it 'working output in system' do
    # expect { described_class.new.print_output(str) }.to output(str + "\n").to_stdout
  end
end
