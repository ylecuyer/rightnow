require 'virtus'

module Rightnow
  class Post
    include Virtus

    attribute :id, Integer
    attribute :hash, String
    attribute :web_url, String
    attribute :api_url, String
    attribute :status, Integer
    attribute :hive_id, Integer
    attribute :post_type_id, Integer
    attribute :post_type_name, String
    attribute :answer_id, Integer
    attribute :answer_selected_by_id, Integer
    attribute :answer_selected, Boolean # ?
    attribute :created, Integer
    attribute :created_by_id, Integer
    attribute :created_by_name, String
    attribute :created_by_hash, String
    attribute :created_by_avatar, String
    attribute :last_activity, Integer
    attribute :name, String
    attribute :comment_count, Integer
    attribute :flag_count, Integer
    attribute :view_count, Integer
    attribute :rating_count, Integer
    attribute :rating_total, Integer
    attribute :preview, String

    def created_at
      Time.at(created)
    end

    def last_activity_at
      Time.at(created)
    end

  end
end