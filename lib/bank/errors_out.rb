# frozen_string_literal: true

class ErrorsOut
  def initialize; end

  def id_does_not_exist
    'ERROR: ACCOUNT NUMBER DOESN\'T EXIST'
  end

  def wrong_password
    'ERROR: ACCOUNT NUMBER AND PASSWORD DON\'T MATCH'
  end
end