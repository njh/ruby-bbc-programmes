require 'rubygems'
require 'yard'

begin
  gem 'jeweler'
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "bbc-programmes"
    gemspec.summary = "Ruby client library for the BBC Programmes website."
    gemspec.email = "njh@aelius.com.com"
    gemspec.homepage = "http://github.com/njh/bbc-programmes-ruby"
    gemspec.authors = ["Nicholas J Humfrey"]
    gemspec.add_dependency('rdf', '>= 0.2.2')
    gemspec.add_dependency('nokogiri', '>= 1.3.3')
    gemspec.add_development_dependency('rspec')
    gemspec.add_development_dependency('yard')
    gemspec.extra_rdoc_files     = %w(README.md)
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/*.spec'
  spec.spec_opts = ["-c"]
end

desc "Run specs through RCov"
Spec::Rake::SpecTask.new("spec:rcov") do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/*.spec'
  spec.rcov = true
  spec.rcov_opts = ['-x', '/Library', '-x', '/System/Library', '-x', 'spec']
end

desc "Generate HTML report specs"
Spec::Rake::SpecTask.new("doc:spec") do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/*.spec']
  spec.spec_opts = ["--format", "html:doc/spec.html"]
end

YARD::Rake::YardocTask.new do |t|
  t.files   = %w(lib/**/*.rb)
end

task :default => :spec
