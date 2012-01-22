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
  # `===` or `=~` evaluate postively.
  #
  # @todo Should `#=~` be apart of this?
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
    self.=~(other)
  end

end
