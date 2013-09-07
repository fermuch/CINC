require 'spec_helper'

describe Student do
  before(:each) do
    @student = Fabricate(:student)
  end

  it "has a valid machine" do
    @student.machine.sn.should be_true
  end
end
