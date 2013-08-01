require 'spec_helper'

describe School do

  let(:school)  { FactoryGirl.build(:school) }
  let(:courses) { FactoryGirl.create_list(:course, 3, school: school) }

  subject { school }

  it { should be_valid }

  context 'when name is blank' do
    let(:school) { FactoryGirl.build(:school, name: "") }

    it { should_not be_valid }
  end

  context 'when name is nil' do
    let(:school) { FactoryGirl.build(:school, name: nil) }

    it { should_not be_valid }
  end

  context 'associations' do
    its(:courses) { should =~ courses }
  end
end


