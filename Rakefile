require 'rake/testtask'

desc 'Run all tests by default'
task :default => :test

task :test do
    Rake::TestTask.new do |t|
        t.libs << "test"
        t.test_files = FileList['test/test_*.rb']
        t.verbose = true
    end
end
