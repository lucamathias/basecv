require "option_parser"
require "io"

module Basecv
  base = 10     # default input base is decimal
  new_base = 16 # default output base is hexadecimal
  upcase = false
  usage = IO::Memory.new

  OptionParser.parse do |parser|
    parser.banner = "Usage: basecv <num> [options]"
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
    usage.puts parser if usage.empty?
  end

  if ARGV.size == 0
    STDERR.puts "ERROR: no input number provided."
    STDERR.puts usage
    exit(1)
  end

  input = ARGV.first

  # convert the input and output the result
  begin
    output = input.to_i(base).to_s(new_base)
    puts upcase ? output.upcase : output
  rescue ex : Exception
    STDERR.puts "ERROR: input '#{input}' does not fit the base '#{base}'."
    STDERR.puts usage
    exit(1)
  end
end
