require "option_parser"
require "io"
require "./converter"

usage = IO::Memory.new

converter = Converter.new
begin
  OptionParser.parse do |parser|
    parser.banner = "Usage: basecv <num> [options]"
    parser.on("-f <base>", "--from <base>", "Base of the input [2-36], default = 10") do |from|
      base = from.to_i
      converter.base = base
    rescue arg : ArgumentError
      raise InvalidBaseException.new(from)
    end
    parser.on("-t <base>", "--to <base>", "Base of the output [2-36], default = 16") do |to|
      new_base = to.to_i
      converter.new_base = new_base
    rescue arg : ArgumentError
      raise InvalidBaseException.new(to)
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

  input = ARGV.first
  puts converter.convert input
rescue ex
  if ex.is_a? InvalidBaseException | WrongBaseException
    STDERR.puts ex
  elsif ex.is_a? Enumerable::EmptyError
    STDERR.puts "ERROR: no input number provided."
  end
  STDERR.puts usage
  exit 1
end
