Pod::Spec.new do |s|
  s.name = 'SAAdLoader'
  s.version = '1.1.8'
  s.summary = 'SAAdLoader handles all SA AA ad loading'
  s.description = <<-DESC
    The SAAdLoader library handles all AwesomeAds ad loading for the SDK. The end result is a either a valid playable ad or a failure callback.
			DESC
  s.homepage = 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader'
  s.license = { 
	:type => 'GNU GENERAL PUBLIC LICENSE Version 3', 
	:file => 'LICENSE' 
  }
  s.author = { 
	'Gabriel Coman' => 'gabriel.coman@superawesome.tv' 
  }
  s.source= { 
	:git => 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader.git', 
	:branch => 'master',
	:tag => '1.1.8' 
  }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'SAModelSpace', '0.5.4'
  s.dependency 'SAUtils', '1.5.4'
  s.dependency 'SANetworking', '0.3.1'
  s.dependency 'SASession', '0.3.8'
  s.dependency 'SAVASTParser', '1.7.4'
end
