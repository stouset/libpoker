require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

require 'spec/spec_helper'

Rake::RDocTask.new(:doc) do |t|
  t.rdoc_dir   = 'doc'
  t.rdoc_files = FileList['lib/**/*.rb']
end

Spec::Rake::SpecTask.new do |t|
  t.libs = %w{ lib }
  t.rcov = true
  
  t.spec_files = FileList['spec/**/*_spec.rb']  
  t.spec_opts  = t.read_opts('spec/spec.opts')
  
  t.rcov_opts = t.read_opts('spec/rcov.opts')
end

namespace :spec do
  RCov::VerifyTask.new(:rcov) do |t|
    t.threshold = 100
  end
  
  Spec::Rake::SpecTask.new(:doc) do |t|
    t.libs = %w{ lib }
    
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.spec_opts  = %w{ --colour --format nested --dry-run }
  end
end