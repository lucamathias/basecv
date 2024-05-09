class Converter
  setter base, new_base, upcase
  getter base, new_base, upcase

  # creates a new Converter from base (default = 10) to new_base (default = 16)
  def initialize(base : Int32 = 10, new_base : Int32 = 16, upcase : Bool = false)
    @base = base
    @new_base = new_base
    @upcase = upcase
  end

  # takes a number of @base as String and converts it to @new_base
  def convert(num : String)
    output = num.to_i(base).to_s(new_base)
    upcase ? output.upcase : output
  rescue ex
    raise "ERROR: input '#{num}' does not fit the base '#{base}'."
  end
end
