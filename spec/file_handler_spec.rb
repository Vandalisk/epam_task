require 'spec_helper'
require './lib/file_handler.rb'

RSpec.describe FileHandler do
  subject { described_class.new(params) }

  context 'valid' do
    let(:params) { 'spec/fixtures/webserver.log.example' }
    let(:expected_result) do
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

    it do
      subject.call

      expect(subject.success?).to be_truthy
      expect(subject.errors).to be_empty
      expect(subject.result).to eq(expected_result)
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
