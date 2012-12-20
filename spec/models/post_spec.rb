require 'spec_helper'

describe Rightnow::Post do
  let(:post) { Rightnow::Post.new(data) }

  context "from search result" do
    let(:data) { fixture('post.rb', :ruby).underscore }

    it "stores search attributes correctly" do
      post.id.should == 58
      post.hash.should == "fa8e6cc713"
      post.web_url.should == "http://communityname.com/posts/fa8e6cc713"
      post.hive_id.should == 72
      post.created.should == 1250703211
      post.created_at.should == Time.utc(2009, 8, 19, 17, 33, 31)
      post.last_activity_at.should == Time.utc(2009, 8, 19, 17, 33, 31)
      post.preview.should =~ /White Page Tester/
      post.post_type.should == {'id' => 109}
      post.answer_id.should be_nil
    end
  end

  context "from PostGet call" do
    let(:data) { fixture('post_get.json', :json).underscore['post'] }

    it "stores detailed attributes correctly" do
      post.uri.should == "http://communityname.com/api/posts/81d3c4ebd8"
      post.post_type.should == {'uri' => "http://communityname.com/api/hives/8054cbc1b4/types/97", 'name' => 'Onderwerp'}
      post.created.should == 1354694056
      post.last_edited.should == 1355333163
      post.event_start.should == Time.at(0)
      post.event_end.should == Time.at(0)
      post.event_time_zone.should == ""
      post.title.should == "Decoder V4: firmware update Charles2_2.7.5.62  (04\/12\/12)"
      post.status.should == 1
      post.comment_count.should == 65
      post.view_count.should == 795
      post.rating_count.should == 0
      post.rating_total.should == 0
      post.flag_count.should == 0
    end

    it "stores creator as user" do
      post.created_by.should be_instance_of(Rightnow::User)
      post.created_by.hash.should == "45394358f2"
      post.created_by.uri.should == "http://communityname.com/api/users/45394358f2"
      post.created_by.login_id.should == "45394358f2"
      post.created_by.name.should == "Elsa"
      post.created_by.avatar.should == "http://communityname.com/files/b6eec94a24/mickey_plays_accordion.gif"
    end

    it "stores last editor as user" do
      post.last_edited_by.should be_instance_of(Rightnow::User)
      post.last_edited_by.hash.should == "45394358f2"
      post.last_edited_by.uri.should == "http://communityname.com/api/users/45394358f2"
      post.last_edited_by.login_id.should == "45394358f2"
      post.last_edited_by.name.should == "Elsa"
      post.last_edited_by.avatar.should == "http://communityname.com/files/b6eec94a24/mickey_plays_accordion.gif"
    end

    it "stores fields details" do
      post.fields.should have(2).items
      # Title
      post.fields.first.should be_instance_of(Rightnow::Field)
      post.fields.first.id.should == 40695
      post.fields.first.value.should =~ /Decoder V4/
      post.fields.first.name.should == "Titel"
      post.fields.first.type.should == 1
      # Content
      post.fields.last.should be_instance_of(Rightnow::Field)
      post.fields.last.id.should == 40696
      post.fields.last.value.should =~ /gevolge van de nieuwe/
      post.fields.last.name.should == "Content"
      post.fields.last.type.should == 4
    end
  end
end