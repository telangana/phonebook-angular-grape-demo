require 'grape'
require 'active_model'

require_relative 'app/formatters/csv'
require_relative 'app/models/contact'
require_relative 'framework/persistence/memory'
require_relative 'framework/persistence/redis'
require_relative 'app/entities/contact'
