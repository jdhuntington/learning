$length = ARGV.first.to_i
File.read('wordlist').each_line do |line|
  line.strip!
  puts line.downcase if line.length == $length
end
