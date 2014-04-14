module Framework
  module Persistence
    class Redis

      def initialize(klass, namespace = 'phonebook')
        @klass = klass
        @klass_name = klass.name
        @store = ::Redis::Namespace.new([namespace, @klass_name].join('::'))

        if @store.exists(index_key)
          @id = @store.get(index_key).to_i
        else
          @id = 1
        end
      end

      def find(id)
        @store.get([@klass_name, id].join('::'))
      end

      def add(item)
        # save the item
        item.id = @id
        @store.set([@klass_name, item.id].join('::'), item.to_json)
        @id += 1
        @store.incr(index_key)
        item
      end

      def update(item)
        return nil if item.id.nil?
        old = find(item.id.to_i)
        return nil if old.nil?

        @store.set([@klass_name, item.id.to_i].join('::'), item.to_json)
        item
      end

      def delete(id)
        if item = find(id)
          @store.del([@klass_name, id].join('::'))
          item
        else
          nil
        end
      end

      def all
        keys = @store.keys("#{@klass_name}::*")
        unless keys.empty?
          @store.mget(*keys).map{|item_data| @klass.new(MultiJson.load(item_data)) }
        else
          []
        end
      end

      def clear!
        keys = @store.keys('*')
        unless keys.empty?
          @store.del(keys)
        end
      end

      private

      def index_key
        ['index', @klass_name, '__id__'].join('::')
      end

      def item_id(item)
        (item.id || @id).to_i
      end
    end
  end
end