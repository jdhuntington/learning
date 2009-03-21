require 'spec'
$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'string_subber'

describe StringSubber do
  it 'should return original string if nothing magic is done' do
    StringSubber.new('Lorem Ipsum').interpolate.should == 'Lorem Ipsum'
  end

  it 'should replace a "$variable" with what\'s in a hash' do
    s = StringSubber.new 'Lorem $blank Dolor'
    result = s.interpolate({ :blank => 'Ipsum' })
    result.should == 'Lorem Ipsum Dolor'
  end

  it "should replace two variables with hash values" do
    s = StringSubber.new 'wibble $wobble $werble woo'
    result = s.interpolate({ :wobble => 'bar', :werble => 'something' })
    result.should == 'wibble bar something woo'
  end

  it 'should handle variables that are very similar' do
    s = StringSubber.new '$a $a1 $aa $ab'
    result = s.interpolate({ :a => 'hi', :a1 => 'hello', :aa => 'gutentag', :ab => 'tchus' })
    result.should == 'hi hello gutentag tchus'
  end
end
