require 'spec_helper'
require './lib/list_views.rb'

RSpec.describe ListViews do
  subject { described_class.new(params) }

  context 'valid' do
    let(:params) { 'any_file_name' }
    let(:file_handler_double) { double(:file_handler, call: handler_result, success?: true) }
    let(:handler_result) do
      {
        most_page_views: [
          ["/help_page", 3],
          ["/about", 3],
          ["/index", 1],
          ["/home", 1],
          ["/contact", 1]
        ],
        most_unique_views: [
          ["/about/2", 2],
          ["/index", 1],
          ["/home", 1],
          ["/help_page/1", 1],
          ["/contact", 1],
          ["/about", 1]
        ]
      }
    end

    before do
      allow(FileHandler).to receive(:new).with(params).and_return(file_handler_double)
    end

    it do
      subject.call

      expect(subject.success?).to be_truthy
      expect(subject.errors).to be_empty
    end
  end

  context 'invalid' do
    let(:params) { 'server.log' }

    it do
      subject.call

      expect(subject.success?).to be_falsey
    end
  end
end
