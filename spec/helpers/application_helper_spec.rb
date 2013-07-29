require 'spec_helper'

describe ApplicationHelper do
  describe '#header_button_class' do
    it 'is btn for non selected button' do
      selected_button = :home
      this_button = :not_home

      css_class = header_button_class(selected_button, this_button)

      expect(css_class).to eq('btn')
    end

    it 'is btn btn-success for selected button' do
      selected_button = :home
      this_button = :home

      css_class = header_button_class(selected_button, this_button)

      expect(css_class).to eq('btn btn-success')
    end

  end

end