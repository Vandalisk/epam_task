#!/usr/bin/ruby

require './lib/list_views.rb'

file_name = ARGV[0]

ListViews.new(file_name).call
