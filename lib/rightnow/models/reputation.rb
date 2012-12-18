require 'virtus'

module Rightnow
  class Reputation
    include Virtus

    attribute :level, String
    attribute :score, Integer
    attribute :avatar, String
  end
end