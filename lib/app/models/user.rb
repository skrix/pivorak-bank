# frozen_string_literal: true

# user.rb
# User class defined for
# storing information about
# users
class User
  NAME     = 'name'
  PASSWORD = 'password'

  def initialize(user_id, options)
    @user_id   = user_id
    @user_name = options.fetch(NAME).to_s
    @password  = options.fetch(PASSWORD).to_s
  end

  attr_reader :user_id, :user_name, :password
end
