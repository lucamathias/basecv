require "big"
require "./exceptions"

class Converter
  setter upcase
  getter base, new_base, upcase

  # creates a new Converter from base (default = 10) to new_base (default = 16)
  def initialize(base : Int32 = 10, new_base : Int32 = 16, upcase : Bool = false)
    check_base(base)
    check_base(new_base)
    @base = base
    @new_base = new_base
    @upcase = upcase
  end

  def base=(base)
    check_base(base)
    @base = base
  end

  def new_base=(new_base)
    check_base(new_base)
    @new_base = new_base
  end

  def check_base(base)
    if base < 2 || base > 36
      raise InvalidBaseException.new(base)
    end
  end

  # takes a number of @base as String and converts it to @new_base
  def convert(num : String)
    i = BigInt.new(str: num, base: base)
    output = i.to_s(new_base)
    upcase ? output.upcase : output
  rescue ex
    if ex.is_a? InvalidBaseException
      raise ex
    else
      raise WrongBaseException.new(num, base)
    end
  end
end
