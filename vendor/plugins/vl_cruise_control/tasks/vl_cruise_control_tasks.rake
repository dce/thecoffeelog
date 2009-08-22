module VlCruiseControl
  class CoverageTasks < Rake::TaskLib
    def initialize(target = 100, options = {})
      raise "#{target}% coverage is unattainable" unless (0..100).include?(target)

      begin
        require 'rcov/rcovtask'

        namespace :viget do
          namespace :coverage do

            desc "Generate RCov coverage report"
            if Rake::Task.task_defined?('viget:coverage:report:local')
              task :report => 'viget:coverage:report:local'
            elsif Rake::Task.task_defined?('spec:rcov')
              task :report => 'spec:rcov'
            else
              Rcov::RcovTask.new(:report) do |t|
                t.test_files = FileList['test/unit/**/*.rb','test/functional/**/*.rb']
                t.rcov_opts << "-I #{RAILS_ROOT}/test --rails -x '/Library/Ruby' -x 'plugins' -x 'gems' -x '/usr/lib/ruby' -x '/usr/lib64/ruby'"
              end
            end

            desc "Ensure at least #{target}% test coverage"
            task :ensure => :report do
              # thanks to RSpec for this logic
              coverage = nil
              File.open('coverage/index.html').each do |line|
                if line =~ /<tt class='coverage_code'>(\d+\.\d+)%<\/tt>/
                  coverage = $1.to_f
                  break
                end
              end
              if options[:exact]
                raise "Coverage is #{coverage}%; should be exactly #{target}%" if coverage != target
              else
                raise "Coverage is #{coverage}%; should be at least #{target}%" if coverage < target
              end
            end

            task :load_db do
              ENV['RAILS_ENV'] = 'test'

              %w(viget:db:load vl:db_load db:test:prepare).each do |name|
                if Rake::Task.task_defined?(name)
                  Rake::Task[name].invoke
                  break
                end
              end
            end

          end
        end

        namespace :vl do
          namespace :coverage do
            task :report => 'viget:coverage:report'
            task :ensure => 'viget:coverage:ensure'
          end
        end

        task :cruise => ['viget:coverage:load_db','viget:coverage:ensure']

      rescue LoadError
        nil
      end
    end
  end
end

def require_coverage(target, options = {})
  # backwards compatibility
  options = {:exact => true} if options == true
  VlCruiseControl::CoverageTasks.new(target.to_f, options)
end
