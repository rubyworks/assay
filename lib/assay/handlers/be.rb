# TODO: What about BasicObject ?

class Object

  #
  #
  #
  def be(matcher)
    if matcher
      matcher === self
    else
      ToBe.new(self)
    end
  end

end

