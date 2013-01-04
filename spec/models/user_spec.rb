require 'spec_helper'

describe Rightnow::Models::User do
  let(:user) { Rightnow::Models::User.new(data) }

  context "from PostGet call" do
    let(:data) { fixture('post_get.json', :json).underscore['post']['created_by'] }

    it "should have correct attributes" do
      user.hash.should == "45394358f2"
      user.name.should == "Elsa"
      user.avatar.should == "http://communityname.com/files/b6eec94a24/mickey_plays_accordion.gif"
    end

    it "should set api_uri" do
      user.api_uri.should == "http://communityname.com/api/users/45394358f2"
    end
  end

  context "from CommentList call" do
    let(:data) { fixture('comment_list.json', :json).underscore['comments'].first['created_by'] }

    it "should have correct attributes" do
      user.guid.should == 35948
      user.web_uri.should == "http://communityname.com/people/3e2ce69336"
      user.api_uri.should == "http://communityname.com/api/users/3e2ce69336"
      user.name.should == "Francoise ."
      user.avatar.should == "http://communityname.com/common/images/avatars/user/default.jpg"
    end

    it "should guess hash from URI if not present" do
      data['hash'].should be_nil
      user.hash.should == "3e2ce69336"
    end
  end

  context "from UserGet call" do
    let(:data) { fixture('user_get.json', :json).underscore['user'] }

    it "should have correct attributes" do
      user.hash.should == "45394358f2"
      user.guid.should == 21709
      user.user_id.should == 19982
      user.api_uri.should == "http://communityname.com/api/users/45394358f2"
      user.name.should == "Elsa"
      user.avatar.should == "http://communityname.com/files/b6eec94a24/mickey_plays_accordion.gif"
      user.email.should == "elsa.foster-cg8p1qi@yopmail.com"
      user.type.should == 6
      user.status.should == 1
    end

    it "should have reputation fields" do
      user.reputation.should be_instance_of(Rightnow::Models::Reputation)
      user.reputation.level.should == "Intense User"
      user.reputation.score.should == 122500
      user.reputation.avatar.should == "/files/716841fe8c/icon_mem_intense.png"
    end
  end
end