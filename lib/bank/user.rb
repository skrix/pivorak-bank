# frozen_string_literal: true

# user.rb
# User class defined for
# storing information about
# users
class User
  attr_accessor :user_id, :user_name, :password

  def initialize(user_id, options)
    @user_id    = user_id
    @user_name  = options.fetch('name')
    @password   = options.fetch('password')
  end
end
