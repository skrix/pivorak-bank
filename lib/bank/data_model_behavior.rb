# frozen_string_literal: true

# data_model_behavior.rb
module DataModelBehavior
  def auto_id
    @id ||= 0
    @id += 1
  end
end
