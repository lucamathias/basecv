require "./spec_helper"

describe Converter do
  describe "#convert" do
    it "converts from dec to hex by default" do
      converter = Converter.new
      converter.convert("26").should eq "1a"
      converter.convert("11").should eq "b"
      converter.convert("2748").should eq "abc"
    end

    it "can convert from dec to bin" do
      converter = Converter.new(10, 2)
      converter.convert("4").should eq "100"
      converter.convert("777").should eq "1100001001"
      converter.convert("1024").should eq "10000000000"
    end

    it "raises an exception on wrong base" do
      converter = Converter.new(2, 10)
      expect_raises(Exception) do
        converter.convert("11112")
      end
    end

    it "converts bases higher than 16" do
      converter = Converter.new(10, 36)
      converter.convert("35").should eq "z"
    end

    it "handles large numbers" do
      converter = Converter.new(10, 25)
      converter.convert("3423353456346456456456553453453453654").should eq "1ddehhi32cfnd74e3lihk8fl0l4"
    end

    it "raises and exception for invalid base" do
      converter = Converter.new
    end

    it "does not upcase on default" do
      converter = Converter.new
      converter.convert("15").should eq "f"
    end

    it "does upcase when specified" do
      converter = Converter.new(upcase: true)
      converter.convert("14").should eq "E"
    end
  end
end
