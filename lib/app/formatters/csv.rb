require 'csv'

module Phonebook
  module Formatters
    class CSV

      def self.call(object, env)
        return nil if object.nil? || object.empty?

        ::CSV.generate(col_sep: "\t", encoding: 'UTF-8') do |csv|

          attributes = object.first.serializable_hash(to_h: true).keys
          csv << attributes.map(&:to_s)

          object.each do |obj|
            csv << attributes.map{|h| obj.serializable_hash(to_h: true)[h] }
          end
        end

      end

    end
  end
end