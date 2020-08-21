require './lib/callable.rb'
require './lib/db.rb'

class FileHandler < Callable
  include DB

  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    return unless file

    with_database do |db|
      file.each_line do |row|
        insert_row(db, row)
      end

      @result = { most_page_views: most_page_views(db), most_unique_views: most_unique_views(db) }
    end
  end

  private

  def file
    @file ||= check_file
  end

  def check_file
    begin
      File.open(file_name, 'r')
    rescue Errno::ENOENT => e
      puts 'Exception occurred while file openning'
      puts e

      fail!
    end
  end
end
