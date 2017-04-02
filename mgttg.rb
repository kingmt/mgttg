require_relative 'lib/mgttg_logic'


# main loop
if ARGV.empty?
  puts "No input file given!"
else
  file_name = ARGV[0]
  if File.exist?(file_name)
    mgttg = MgttgLogic.new(file_name)
    mgttg.run
  else
    puts "File doesn't exist!"
  end
end
