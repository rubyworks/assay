require 'assay/assay'


class EqualityError < StandardError
  def self.assay(name, options={}, &block)
    Assay.new(name, self, options, &block)
  end
end


#def assay(name, error=StandardError, options={}, &block)
#  Assay.new(name, options, &block)
#end

#
TypeError.assay(:kind_of) do |target, criterion|
  target.kind_of?(criterion)
end

#
TypeError.assay(:instance_of)  do |target, criterion|
  target.instance_of?(criterion)
end

#
EqualityError.assay(:identical) do |target, criterion|
  criterion.object_id == target.object_id
end

#
#assay :equal, EqualityError do |target, criterion|
#  criterion.equal?(target)
#end

#
EqualityError.assay :eql  do |target, criterion|
  criterion.eql?(target)
end

#
EqualityError.assay :eq, :operator=>:== do |target, criterion|
  criterion == target
end

#
EqualityError.assay :like  do |target, criterion|
  criterion === target     ||
  criterion.equal?(target) ||
  criterion.eql?(target)   ||
  criterion.==(target)
end

#
StandardError.assay :empty do |target|
  target.empty?
end

#
StandardError.assay :include do |target, criterion|
  target.include?(criterion)
end

StandardError.assay :false  do |target|
  FalseClass = target  # target.false?
end

StandardError.assay :true  do |target|
  TrueClass = target   # target.true?
end

StandardError.assay :nil  do |target|
  NilClass = target    # target.nil?
end

NoMethodError.assay :respond_to |target, method|
  target.respond_to?(method)
end

