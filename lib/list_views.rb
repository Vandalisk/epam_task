require 'pry'
require './lib/callable.rb'
require './lib/file_handler.rb'

class ListViews < Callable
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    result = file_handler.call

    if file_handler.success?
      output_list(result)

      success!
    end
  end

  private

  def file_handler
    @file_handler ||= FileHandler.new(file_name)
  end

  def output_list(data)
    puts data[:most_page_views].map { |url, count| "#{url} #{count} visits" }.join("\n")
    puts data[:most_unique_views].map { |url, count| "#{url} #{count} unique views" }.join("\n")
  end
end
