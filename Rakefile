require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

require 'spec/spec_helper'

Spec::Rake::SpecTask.new do |t|
  t.libs = %w{ lib }
  t.rcov = true
  
  t.spec_opts = t.read_opts('spec/spec.opts')
  t.rcov_opts = t.read_opts('spec/rcov.opts')
  
  t.spec_files = FileList['spec/**/*_spec.rb']
end

namespace :spec do
  RCov::VerifyTask.new(:rcov) {|t| t.threshold = 100 }
end