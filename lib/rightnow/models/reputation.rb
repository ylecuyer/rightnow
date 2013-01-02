require 'virtus'

module Rightnow
  module Models
    class Reputation
      include Virtus

      attribute :level, String
      attribute :score, Integer
      attribute :avatar, String
    end
  end
end