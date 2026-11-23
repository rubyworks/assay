require 'assay/ae'

# The other demos share a few helper methods (`assert`, `refute`,
# `expect`) that the AE notation has its own versions of. In these
# demos the names mean AE's.
[:assert, :assert!, :refute, :flunk].each do |name|
  define_method(name, Assay::AE::Assert.instance_method(name))
end
[:expect, :expect!, :forbid].each do |name|
  define_method(name, Assay::AE::Expect.instance_method(name))
end
