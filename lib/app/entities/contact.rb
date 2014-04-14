module Phonebook
  module Entities
    class Contact < Grape::Entity
      expose :id
      expose :name
      expose :phone
    end
  end
end