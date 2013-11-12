require 'virtus'
require 'rightnow/models/user'
require 'rightnow/models/field'

module Rightnow
  module Models
    class Post
      include Virtus.model

      # UserGet attributes
      attribute :uri, String
      attribute :post_type, Hash[String => String]
      attribute :created, Integer
      attribute :created_by, User
      attribute :last_edited, Integer
      attribute :last_edited_by, User
      attribute :event_start, Time
      attribute :event_end, Time
      attribute :event_time_zone, String
      attribute :title, String
      attribute :status, Integer
      attribute :comment_count, Integer
      attribute :view_count, Integer
      attribute :rating_count, Integer
      attribute :rating_total, Integer
      attribute :flag_count, Integer
      attribute :fields, Array[Field]

      # Search only attributes
      attribute :id, Integer
      attribute :hash, String
      attribute :web_url, String
      attribute :hive_id, Integer
      attribute :answer_id, Integer
      attribute :answer_selected_by_id, Integer
      attribute :answer_selected, Boolean # ?
      attribute :last_activity, Integer
      attribute :preview, String

      def post_type_id= value
        self.post_type ||= {}
        self.post_type['id'] = value
      end

      def created_at
        Time.at(created)
      end

      def last_edited_at
        Time.at(last_edited)
      end

      def last_activity_at
        Time.at(last_activity)
      end

    end
  end
end