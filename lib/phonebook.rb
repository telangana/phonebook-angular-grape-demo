require 'grape'
require 'active_model'

require_relative 'app/formatters/csv'
require_relative 'app/models/contact'
require_relative 'app/persistence/memory'
require_relative 'app/persistence/redis'
require_relative 'app/entities/contact'
