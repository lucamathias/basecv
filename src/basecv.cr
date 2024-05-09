require "option_parser"

base = 10     # default is decimal
new_base = 16 # default is hexadecimal
upcase = false

input = ARGV.first

OptionParser.parse do |parser|
  parser.banner = "Usage: basecr <num> [options]"
  parser.on("-b <base>", "--from <base>", "Base of the input, default = 10") do |b|
    begin
      base = b.to_i
      raise Exception.new if base < 2
    rescue ex : Exception
      STDERR.puts "ERROR: '#{b}' is not a valid base."
      STDERR.puts parser
      exit(1)
    end
  end
  parser.on("-B <base>", "--to <base>", "Base of the output, default = 16") do |nb|
    begin
      new_base = nb.to_i
      raise Exception.new if base < 2
    rescue ex : Exception
      STDERR.puts "ERROR: '#{nb}' is not a valid base."
      STDERR.puts parser
      exit(1)
    end
  end
  parser.on("-u", "--upcase", "Upcase the result") { upcase = true }
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

# convert the input and output the result
begin
  output = input.to_i(base).to_s(new_base)
  puts upcase ? output.upcase : output
rescue ex : Exception
  STDERR.puts "ERROR: input '#{input}' does not fit the base '#{base}'."
  exit(1)
end
