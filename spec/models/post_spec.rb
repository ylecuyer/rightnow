require 'spec_helper'

describe Rightnow::Post do
  let(:post) { Rightnow::Post.new(fixture('post.rb', :ruby).underscore) }

  it "stores attributes correctly" do
    post.id.should == 58
    post.hash.should == "fa8e6cc713"
    post.api_url.should == "http://communityname.com/api/posts/fa8e6cc713"
    post.created.should == 1250703211
    post.created_at.should == Time.utc(2009, 8, 19, 17, 33, 31)
    post.answer_id.should be_nil
  end
end