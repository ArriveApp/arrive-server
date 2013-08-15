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

end
