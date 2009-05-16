#!/usr/bin/ruby
require 'yaml'

directory = ARGV[0]

file_list = Dir.new(directory).entries.collect{ |file_name| File.join(directory, file_name) if File.file?(File.join(directory, file_name)) }.compact.sort

puts "File list: #{file_list}"
doc = {}
file_list.each do |file_name|
    doc = File.open(file_name, "r") do |fd|
	    puts "Opening file: #{file_name}"
	    YAML::load(fd)
    end
    doc.each do |key,value|
        doc[key] = Hash.new
        doc[key]['oid'] = value
    end
    puts "new doc: #{doc.inspect}"

    File.open(file_name, 'w') do |fd|
        YAML.dump(doc, fd)
    end
end

