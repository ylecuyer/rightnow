require 'virtus'
require 'rightnow/models/reputation'

module Rightnow
  module Models
    class User
      include Virtus

      attribute :guid, String
      attribute :hash, String, default: lambda { |u,v| u.api_uri.scan(/[0-9a-z]{10}\z/).first }
      attribute :web_uri, String
      attribute :api_uri, String
      attribute :login_id, String
      attribute :user_id, Integer
      attribute :name, String
      attribute :avatar, String
      attribute :email, String
      attribute :type, Integer
      attribute :status, Integer
      attribute :guid, Integer
      attribute :created, Integer
      attribute :last_login, Integer
      attribute :buddy_count, Integer
      attribute :group_count, Integer
      attribute :hive_count, Integer
      attribute :post_count, Integer
      attribute :comment_count, Integer
      attribute :comments_selected_as_best_answer_count, Integer
      attribute :reputation, Reputation

      def created_at
        Time.at(created)
      end

      def last_login_at
        Time.at(last_login)
      end

      def uri= value
        self.api_uri = value
      end
    end
  end
end