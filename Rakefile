require 'rubygems/package_task'

gemspec = Gem::Specification.load('assay.gemspec')

Gem::PackageTask.new(gemspec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

# Each notation extends Object in its own way, so each set of demos runs
# in a process of its own.
DEMOS = %w[core minitest testunit rspec fluidity]

desc "Run the QED demos"
task :demo do
  DEMOS.each do |set|
    sh "bundle exec qed -Ilib demo/#{set}"
  end
end

desc "Run the unit tests"
task :test do
  sh 'bundle exec rubytest -Ilib -r ./test/helper test/case_*.rb'
end

desc "Check the framework adapters"
task :adapters do
  sh 'bundle exec ruby -Ilib test/adapters.rb'
end

task :default => [:demo, :test, :adapters]
