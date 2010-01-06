require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "emcrud"
    gem.summary = %Q{TODO: one-line summary of your gem}
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "info@talho.org"
    gem.homepage = "http://github.com/talho/emcrud"
    gem.authors = ["Keith Gaddis", "Daniel Morrison"]
    gem.add_development_dependency 'rspec'
    gem.add_development_dependency 'cucumber'
    gem.add_development_dependency 'fakeweb'
    gem.add_dependency 'mechanize', '0.9.3'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  task :features => :check_dependencies
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => [:spec, :features]

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "emcrud #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
