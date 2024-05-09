require "option_parser"
require "io"
require "./converter"

usage = IO::Memory.new

converter = Converter.new

OptionParser.parse do |parser|
  parser.banner = "Usage: basecv <num> [options]"
  parser.on("-f <base>", "--from <base>", "Base of the input, default = 10") do |from|
    begin
      base = from.to_i
      converter.base = base
      raise Exception.new if base < 2
    rescue ex : Exception
      STDERR.puts "ERROR: '#{from}' is not a valid base."
      STDERR.puts parser
      exit 1
    end
  end
  parser.on("-t <base>", "--to <base>", "Base of the output, default = 16") do |to|
    begin
      new_base = to.to_i
      converter.new_base = new_base
      raise Exception.new if new_base < 2
    rescue ex : Exception
      STDERR.puts "ERROR: '#{to}' is not a valid base."
      STDERR.puts parser
      exit 1
    end
  end
  parser.on("-u", "--upcase", "Upcase the result") { converter.upcase = true }
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit 1
  end
  usage.puts parser if usage.empty?
end

if ARGV.size == 0
  STDERR.puts "ERROR: no input number provided."
  STDERR.puts usage
  exit 1
end

input = ARGV.first
begin
  puts converter.convert input
rescue ex
  STDERR.puts ex
  exit 1
end
