# frozen_string_literal: true

# io_handler.rb
class InputOutputHandler
  def read_input
    STDIN.gets.chomp
  end

  def print_output(text)
    STDOUT.puts text
  end
end
