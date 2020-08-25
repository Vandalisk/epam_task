require 'pry'
require './lib/callable.rb'
require './lib/db.rb'
# Class for handing file.
class FileHandler < Callable
  include DB

  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    return unless file

    with_database do |db|
      insert_to_db_from_file(db)

      @result = { most_page_views: most_page_views(db), most_unique_views: most_unique_views(db) }
    end
  end

  private

  def file
    @file ||= check_file
  end

  def insert_to_db_from_file(db)
    file.each_line { |row| insert_row(db, row) }
  end

  def check_file
    File.open(file_name, 'r')
  rescue Errno::ENOENT => e
    errors << e.message

    fail!
  end
end
