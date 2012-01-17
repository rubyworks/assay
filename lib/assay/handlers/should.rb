# TODO: What about BasicObject ?

class Object

  #
  #
  #
  def should(matcher=nil)
    if matcher
      matcher =~ self
    else
      ToBe.new(self)
    end
  end

  #
  #
  #
  def should_not(matcher=nil)
    if matcher
      matcher !~ self
    else
      NotToBe.new(self)      
    end
  end

end

