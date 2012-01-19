
class << NA = ArgumentError.new
  def inspect ; 'N/A' ; end
  def method_missing(*); self; end
end

def __
  NA
end
