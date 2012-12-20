require 'spec_helper'

describe Rightnow::Field do
  let(:field) { Rightnow::Field.new(data.underscore) }
  let(:data) { { "id" => 40695, "postTypeField" => {"name" => "Titel", "type" => 1}, "value" => "Value"} }

  it "creates with correct values" do
    field.id.should == 40695
    field.value.should == "Value"
    field.name.should == "Titel"
    field.type.should == 1
  end

end