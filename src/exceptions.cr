class InvalidBaseException < Exception
  def initialize(base)
    super("ERROR: '#{base}' is not a valid base. Bases have to be in range [2-36].")
  end
end

class WrongBaseException < Exception
  def initialize(num : String, base : Int32)
    super("ERROR: '#{num} does not fit the base '#{base}'.")
  end
end
