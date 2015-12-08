module Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    # to see options:
    #   https://github.com/swanandp/acts_as_list
    def sortable(opts = {})
      column = opts[:column] || "position" # acts as list default

      acts_as_list(opts)
      define_column_setter!(column)
      scope :sorted, ->{ order("#{column} ASC") }
      after_destroy :remove_from_list, if: :restorable?
    end

    private

    # let acts_as_list usage like ranked-model
    def define_column_setter!(column)
      self.send :define_method, "#{column}=", ->(value) do
        return if new_record?
        orig_value = public_send(column)
        if value.present?
          insert_at && move_to_bottom if orig_value.blank?
          value = value.to_sym if value.is_a?(String)
          if value.to_s.to_i > 0 || value == "0" || value == 0
            insert_at(value)
          elsif value.is_a?(Symbol)
            case value
            when :up     then move_higher
            when :down   then move_lower
            when :first  then move_to_top
            when :last   then move_to_bottom
            when :remove then remove_from_list
            end
          end
        else
          remove_from_list if orig_value
        end
      end
    end
  end
end
