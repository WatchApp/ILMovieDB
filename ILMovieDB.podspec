Pod::Spec.new do |s|
  s.name     = 'ILMovieDB'
  s.version  = '0.0.2'
  s.license  = 'MIT'
  s.summary  = 'ILMovieDB is a iOS library for interact with themoviedb.org API v3.'
  s.homepage = 'https://github.com/WatchApp/ILMovieDB'
  s.authors  = { 'Gustavo Leguizamon' => 'gustavo@irbislab.com' }
  s.source   = { :git => 'https://github.com/WatchApp/ILMovieDB.git', :tag => '0.0.2' }
  s.source_files = 'ILMovieDB'
  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 2.5'

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'

  s.ios.frameworks = 'MobileCoreServices', 'SystemConfiguration'
  s.osx.frameworks = 'CoreServices', 'SystemConfiguration'

  s.prefix_header_contents = <<-EOS
#ifdef __OBJC__

#if TARGET_OS_IPHONE == 1
#import <MobileCoreServices/MobileCoreServices.h>
#import <SystemConfiguration/SystemConfiguration.h>
#else
#import <CoreServices/CoreServices.h>
#import <SystemConfiguration/SystemConfiguration.h>
#endif

#endif
EOS
end
