namespace :test do
  desc "Run the ILMovieDB Tests"
  task :all do
    system("xctool clean -workspace ILMovieDB.xcworkspace -scheme Tests")
    $success = system("xctool -workspace ILMovieDB.xcworkspace -scheme Tests -sdk iphonesimulator7.0 ONLY_ACTIVE_ARCH=NO -configuration Debug test -test-sdk iphonesimulator -arch i386")
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
