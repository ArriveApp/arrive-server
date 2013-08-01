require 'spec_helper'

describe Course do
  let(:course) { FactoryGirl.build(:course) }

  subject { course }

  it { should be_valid }

  context 'when name is blank' do
    let(:course) { FactoryGirl.build(:course, name: "") }

    it { should_not be_valid }
  end

  context 'when name is nil' do
    let(:course) { FactoryGirl.build(:course, name: nil) }

    it { should_not be_valid }
  end
end

