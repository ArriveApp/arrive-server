require 'spec_helper'

describe ApplicationHelper do
  describe '#nav_class_for' do
    let(:page_identifier) { :some_page }

    it 'is btn for non selected button' do
      active_page_is :another_page

      css_class = nav_class_for(page_identifier)

      expect(css_class).to eq('')
    end

    it 'is btn btn-success for selected button' do
      active_page_is page_identifier

      css_class = nav_class_for(page_identifier)

      expect(css_class).to eq('active')
    end

  end

  describe '#error_messages' do
    it "should return all the error messages on a field" do
      messages = double(:messages => { name: ["error message 1", "error message 2"]})
      model = double(:errors => messages)
      error_messages(model).should == ["error message 1", "error message 2"]
    end

    it "should return all the error messages from multiple field" do
      messages = double(:messages => { name: ["error message 1", "error message 2"], age: ["error message 3", "error message 4"]})
      model = double(:errors => messages)
      error_messages(model).should == ["error message 1", "error message 2", "error message 3", "error message 4"]
    end
  end

end
