require 'spec_helper'
require './lib/list_views.rb'

RSpec.describe ListViews do
  subject { described_class.new(params) }

  context 'valid' do
    let(:params) { 'any_file_name' }
    let(:file_handler_double) { double(:file_handler, call: handler_result, success?: true) }
    let(:handler_result) do
      {
        most_page_views: [ ["/help_page", 3], ["/about", 3] ],
        most_unique_views: [ ["/about/2", 2], ["/index", 1] ]
      }
    end

    let(:expected_output) do
      <<~eos
        /help_page 3 visits
        /about 3 visits
        /about/2 2 unique views
        /index 1 unique views
      eos
    end

    before { allow(FileHandler).to receive(:new).with(params).and_return(file_handler_double) }

    context 'successfull' do
      before { subject.call }

      it { expect(subject.success?).to be_truthy }
      it { expect(subject.errors).to be_empty }
    end

    describe 'should stdout correct result' do
      it { expect { subject.call }.to output(expected_output).to_stdout }
    end
  end

  context 'invalid' do
    let(:params) { file_name }
    let(:file_name) { 'server.log' }

    context 'not successfull' do
      before { subject.call }

      it { expect(subject.success?).to be_falsey }
    end

    describe 'should stdout an exception' do
      it { expect { subject.call }.to output("No such file or directory @ rb_sysopen - #{file_name}\n").to_stdout }
    end
  end
end
