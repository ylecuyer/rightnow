require 'virtus'

module Rightnow
  module Models
    class Field
      include Virtus

      attribute :id, Integer
      attribute :value, String
      attribute :name, String
      attribute :type, Integer

      def post_type_field= type
        self.name = type['name']
        self.type = type['type']
      end
    end
  end
end