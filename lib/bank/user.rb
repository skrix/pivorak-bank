# frozen_string_literal: true

# user.rb
# User class defined for
# storing information about
# users
class User
  attr_accessor :user_id, :user_name, :password

  def initialize(user_id, options)
    @user_id    = user_id
    @user_name  = options.fetch('name').to_s
    @password   = options.fetch('password').to_s
  end
end
