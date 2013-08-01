require 'spec_helper'

describe User do

  let(:school) { FactoryGirl.create(:school) }

  subject { FactoryGirl.build(:user, school: school) }

  context 'associations' do
    its(:school) { should == school }
  end
end
