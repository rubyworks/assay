class Exception

  #
  # This method allows Assay's classes to work in any test framework
  # that supports this interface.
  #
  def assertion?
    @assertion
  end

  #
  # Set assertion flag.
  #
  def set_assertion(boolean)
    @assertion = boolean ? true : false
  end

  #
  # Set message.
  #
  def set_message(msg)
    @mesg = msg.to_str
  end

end

