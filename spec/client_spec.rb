require 'spec_helper'

describe Rightnow::Client do
  let(:client) { Rightnow::Client.new "http://something", :api_key => "API", :secret_key => "SECRET" }

  describe ".initialize" do
    it "should store host and default attributes" do
      client = Rightnow::Client.new "http://community.company.com"
      client.host.should == "http://community.company.com"
      client.api_key.should == nil
      client.secret_key.should == nil
      client.version.should == '2010-05-15'
    end

    it "accepts options" do
      client = Rightnow::Client.new "host", :api_key => "APIKEY", :secret_key => "SECRETKEY", :version => '2042-13-13'
      client.api_key.should == "APIKEY"
      client.secret_key.should == "SECRETKEY"
      client.version.should == '2042-13-13'
    end
  end

  describe "#request" do
    it "compute correct request" do
      stub = stub_request(:get, "http://something/api/endpoint?Action=UserList&ApiKey=API&PermissionedAs=hl_api&Signature=XOyBquzX6vM8b5DO6/By5saSKho=&SignatureVersion=2&format=json&version=2010-05-15").to_return :body => '{}'
      client.request('UserList').should == {}
      stub.should have_been_requested
    end

    it "raise correct exceptions on 401" do
      stub_request(:get, /\Ahttp.*/).to_return(:status => 401, :body => '{"error":{"message":"invalid parameter","code":42}}')
      expect {
        client.request 'UserList'
      }.to raise_error(Rightnow::Error, "invalid parameter (42)")
    end

    it "raise correct exceptions on error without details" do
      stub_request(:get, /\Ahttp.*/).to_return(:status => 401, :body => '{"something":"happened"}')
      expect {
        client.request 'UserList'
      }.to raise_error(Rightnow::Error, 'API returned 401 without explanation: {"something":"happened"}')
    end

    it "raise correct exceptions on bad JSON" do
      stub_request(:get, /\Ahttp.*/).to_return(:status => 200, :body => 'bad')
      expect {
        client.request 'UserList'
      }.to raise_error(Rightnow::Error, 'Bad JSON received: "bad"')
    end
  end

  describe "#signed_params" do
    subject { client.send :signed_params, "Something" }

    it { should include('Action' => 'Something', 'ApiKey' => 'API') }
    it { should include('version' => '2010-05-15', 'SignatureVersion' => '2') }
    it { should include('PermissionedAs' => 'hl_api') }
    it { should include('Signature' => 'L2GWOnez54VB3ywBB2Om332z9FE=') }
    it { should include('format' => 'json') }
    its(:size) { should == 7 }

    context "with custom permission" do
      subject { client.send :signed_params, "Something", :as => 'email@domain.com' }

      it { should include('PermissionedAs' => 'email@domain.com') }
      it { should include('Signature' => 'i66NBNtwG21kxDHYOVMQpb7bhzk=') }
    end
  end
end