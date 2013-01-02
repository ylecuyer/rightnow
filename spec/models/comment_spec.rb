require 'spec_helper'

describe Rightnow::Models::Comment do
  let(:comment) { Rightnow::Models::Comment.new(data) }

  context "from CommentList call" do
    let(:data) { fixture('comment_list.json', :json).underscore['comments'].first }

    it "should have correct attributes" do
      comment.id.should == 94224
      comment.parent_id.should == nil
      comment.uri.should == "http://communityname.com/api/comments/94224"
      comment.status.should == 1
      comment.created_at.should == Time.utc(2012, 12, 17, 17, 24, 8)
      comment.last_edited_at.should == Time.utc(2012, 12, 17, 17, 24, 8)
      comment.rating_count.should == 0
      comment.rating_value_total.should == 0
      comment.rating_weighted.should == 0
      comment.flagged_count.should == 0
      comment.value.should =~ /impossible d&#39;avoir/
    end

    it "stores creator as user" do
      comment.created_by.should be_instance_of(Rightnow::Models::User)
      comment.created_by.guid.should == 35948
      comment.created_by.api_uri.should == "http://communityname.com/api/users/3e2ce69336"
      comment.created_by.name.should == "Francoise ."
      comment.created_by.avatar.should == "http://communityname.com/common/images/avatars/user/default.jpg"
      comment.created_by.hash.should == "3e2ce69336"
    end

    it "stores last editor as user" do
      comment.last_edited_by.should be_instance_of(Rightnow::Models::User)
      comment.last_edited_by.api_uri.should == "http://communityname.com/api/users/3e2ce69336"
      comment.last_edited_by.guid.should == 35948
      comment.last_edited_by.name.should == "Francoise ."
      comment.last_edited_by.avatar.should == "http://communityname.com/common/images/avatars/user/default.jpg"
      comment.last_edited_by.hash.should == "3e2ce69336"
    end
  end
end