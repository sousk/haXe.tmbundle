#!/usr/bin/env ruby
XML = File.join(ENV['TM_PROJECT_DIRECTORY'], 'build.hxml')

def template
  return "bulid.hxml does not exist" unless File.exists?(XML) 

  swffile = nil
  buf = XML
  File.open(XML) do |f|
    f.each do |line|
      if line =~ /-swf\s(\w+\.swf)/
        swffile = File.join(ENV['TM_PROJECT_DIRECTORY'], $1)
        buf += $1
      end
    end
  end
  
  unless swffile
    return "can't find SWF output declaration in hxml file" 
  else
    return %|
      <object id="haXeSWF">
      	<param name="movie" value="{#swffile}" />
      	<param name="quality" value="high" />
      	<param name="bgcolor" value="#FFF" />
      	<param name="allowScriptAccess" value="sameDomain" />
      	<embed src="file://#{swffile}" quality="high" bgcolor="#FFF" name="#{swffile}" 
      		align="middle" play="true" loop="false" quality="high" type="application/x-shockwave-flash" 
      		pluginspage="http://www.macromedia.com/go/getflashplayer" />
      </object>|
    end
end

img2 = "file:///Applications/TextMate.app/Contents/SharedSupport/Support/themes/bright/images/teaser.png"
swf = "file:///Applications/TextMate.app/Contents/SharedSupport/Support/themes/bright/images/app.swf"
puts "hoge<img src=\"file://#{img2}\" />"
puts %| <embed src="#{swf}" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /> foobar|

# puts template()


# #!/usr/bin/env ruby
# FILENAME = ENV['TM_FILENAME']
# FILEPATH = ENV['TM_FILEPATH']
# # SUPPORT  = ENV['TM_BUNDLE_SUPPORT']
# BINARY   = ENV['TM_HAXE_PATH']
# PROJECT = ENV['TM_PROJECT_DIRECTORY']
# HXML = ENV['TM_HAXE_HXMLNAME'] || 'build.hxml'
# 
# hxml = File.join(PROJECT, HXML);
# 
# output = case 
#   when !BINARY:
#     "TM_HAXE_PATH is needed but empty"
#   when !HXML:
#     "TM_HAXE_COMPILING_HXML needed but empty"
#   else
#     Dir.chdir(PROJECT) {
#       `"#{BINARY}" "#{HXML}"`
#     }
# end
# 
# # the "X error(s), Y warning(s)" line will always be at the end
# # results = output.split(/\n/).pop
# # puts results unless results == "0 error(s), 0 warning(s)"
# puts output
