class StringSubber
  def initialize(string)
    @string = string
  end
  
  def interpolate(params={ })
    params.inject(@string) do |string, keyval|
      key, val = *keyval
      string.gsub(/\$#{key}\b/, val)
    end
  end
end
