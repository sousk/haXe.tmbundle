#!/usr/bin/env ruby
FILENAME = ENV['TM_FILENAME']
FILEPATH = ENV['TM_FILEPATH']
# SUPPORT  = ENV['TM_BUNDLE_SUPPORT']
BINARY   = ENV['TM_HAXE_PATH']
PROJECT = ENV['TM_PROJECT_DIRECTORY']
HXML = ENV['TM_HAXE_HXMLNAME'] || 'build.hxml'

hxml = File.join(PROJECT, HXML);

output = case 
  when !BINARY:
    "TM_HAXE_PATH is needed but empty"
  when !HXML:
    "TM_HAXE_COMPILING_HXML needed but empty"
  else
    Dir.chdir(PROJECT) {
      `"#{BINARY}" "#{HXML}"`
    }
end

puts (output.empty?) ? "compiled" : output
