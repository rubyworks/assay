module Assay
  VERSION="1.0.0"
end

dir  = File.dirname(__FILE__)
glob = File.join(dir, 'assay', '*.rb')

Dir[glob].each do |rb|
  require 'assay/' + File.basename(rb)
end

