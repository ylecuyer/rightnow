require 'virtus'
require 'rightnow/models/user'

module Rightnow
  module Models
    class Comment
      include Virtus

      attribute :id, Integer
      attribute :parent_id, Integer
      attribute :uri, String
      attribute :status, Integer
      attribute :created, Integer
      attribute :created_by, User
      attribute :last_edited, Integer
      attribute :last_edited_by, User
      attribute :rating_count, Integer
      attribute :rating_value_total, Integer
      attribute :rating_weighted, Integer
      attribute :flagged_count, Integer
      attribute :value, String

      def created_at
        Time.at(created)
      end

      def last_edited_at
        Time.at(last_edited)
      end
    end
  end
end