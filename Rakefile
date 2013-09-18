namespace :test do
  desc "Run the ILTMDb Tests"
  task :all do
    $success = system("xctool -workspace ILTMDb.xcworkspace -scheme Tests -sdk iphonesimulator -configuration Release test -test-sdk iphonesimulator")
  end
end

task :test => ['test:all'] do
  if $success
    puts "\033[0;32m** All tests executed successfully"
  else
    puts "\033[0;31m! Tests failed"
    exit(-1)
  end
end

task :default => 'test'
