require 'virtus'
require 'rightnow/models/user'

module Rightnow
  class Post
    include Virtus

    attribute :id, Integer
    attribute :parent_id, Integer
    attribute :uri, String
    attribute :status, Integer
    attribute :created, Integer
    attribute :created_at, User
    attribute :last_edited, Integer
    attribute :last_edited_by, User
    attribute :rating_count, Integer
    attribute :rating_value_total, Integer
    attribute :rating_weighted, Integer
    attribute :flagged_count, Integer
    attribute :value, String
  end
end