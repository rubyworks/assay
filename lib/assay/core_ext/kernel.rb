module Kernel

  # Do two references have the same `#object_id`, and hence are the
  # same object.
  #
  # @param [Object] other
  #   Any object reference.
  #
  def identical?(other)
    object_id == other.object_id
  end

  # Ascertain likeness, returns true if any of `equal?`, `eql?`, `==`,
  # `===` or `=~` evaluate truthfully, either with `self` as the receiver
  # or `other` as the receiver.
  #
  # @todo Should `#=~` be apart of this comparison?
  #
  # @param [Object] other
  #   Any object reference.
  #
  # @return [Boolean] +true+ if alike.
  #
  def like?(other)
    self.equal?(other) ||
    self.eql?(other)   ||
    self.==(other)     ||
    self.===(other)    ||
    self.=~(other)     ||
    other.equal?(self) ||
    other.eql?(self)   ||
    other.==(self)     ||
    other.===(self)    ||
    other.=~(self)
  end

  #
  def true?
    TrueClass === self
  end

  #
  def false?
    FalseClass === self
  end

end
