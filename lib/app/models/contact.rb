module Phonebook
  module Model
    class Contact
      include ::ActiveModel::Model
      attr_accessor :name, :phone, :id

      class << self
        attr_accessor :repository
      end

      def id=(id)
        @id = id.to_i
      end

    end
  end
end