Pod::Spec.new do |s|
  s.name = 'SAAdLoader'
  s.version = '1.4.3'
  s.summary = 'SAAdLoader handles all SA AA ad loading'
  s.description = <<-DESC
    The SAAdLoader library handles all AwesomeAds ad loading for the SDK. The end result is a either a valid playable ad or a failure callback.
			DESC
  s.homepage = 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader'
  s.license = { 
	:type => 'GNU LESSER GENERAL PUBLIC LICENSE Version 3', 
	:file => 'LICENSE' 
  }
  s.author = { 
	'Gabriel Coman' => 'gabriel.coman@superawesome.tv' 
  }
  s.source= { 
	:git => 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader.git', 
	:branch => 'master',
	:tag => '1.4.3' 
  }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.dependency 'SAModelSpace', '1.0.1'
  s.dependency 'SAUtils', '1.5.6'
  s.dependency 'SANetworking', '1.0.1'
  s.dependency 'SASession', '1.1.3'
  s.dependency 'SAVASTParser', '1.7.6'
end
