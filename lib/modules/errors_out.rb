# frozen_string_literal: true

class ErrorsOut
  def initialize; end

  def id_does_not_exist
    "ERROR: ACCOUNT NUMBER DOESN'T EXIST"
  end

  def wrong_password
    "ERROR: ACCOUNT NUMBER AND PASSWORD DON'T MATCH"
  end

  def over_the_limit(amount)
    "ERROR: THE MAXIMUM AMOUNT AVAILABLE IN YOUR
     BALANCE IS #{amount} UAH. PLEASE ENTER A
     DIFFERENT AMOUNT:"
  end

  def transfer_error
    "ERROR: YOU CAN'T PERFORM TRANSFER TO THIS PERSON"
  end

  def composing_error
    'ERROR: THE AMOUNT YOU REQUESTED CANNOT
     BE COMPOSED FROM BILLS AVAILABLE IN THIS
     ATM. PLEASE ENTER A DIFFERENT AMOUNT:'
  end
end
