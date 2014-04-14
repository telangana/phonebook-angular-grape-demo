module Phonebook
  module Persistence

    # a simple memory based store
    class Memory
      def initialize
        @store = Hash.new
        @id = 1
      end

      def add(item)
        # save the item
        item.id = @id
        @store[@id] = item
        @id += 1
        item
      end

      def find(id)
        @store[id.to_i]
      end

      def all
        @store.values
      end

      def update(item)
        return nil if item.id.nil?
        old = find(item.id.to_i)
        return nil if old.nil?

        @store[item.id.to_i] = item
        item
      end

    end
  end
end