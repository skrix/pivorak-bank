# frozen_string_literal: true

# user.rb
# User class defined for
# storing information about
# users
class User
  attr_accessor :user_id, :user_name, :password

  def initialize(user_id, database)
    @user_id    = user_id
    @user_name  = database.fetch('name')
    @password   = database.fetch('password')
  end
end
