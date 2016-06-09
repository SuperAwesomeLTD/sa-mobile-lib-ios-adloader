# 'pod lib lint SAAdLoader.podspec' before

Pod::Spec.new do |s|
  s.name             = 'SAAdLoader'
  s.version          = '0.1.3'
  s.summary          = 'SAAdLoader handles all SA AA ad loading'
  s.description      = <<-DESC
 The SAAdLoader library handles all AwesomeAds ad loading for the SDK. The end result is a either a valid playable ad or a failure callback.
			DESC
  s.homepage         = 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader'
  s.license          = { :type => "GNU GENERAL PUBLIC LICENSE Version 3", :file => "LICENSE" }
  s.author           = { 'Gabriel Coman' => 'gabriel.coman@superawesome.tv' }
  s.source           = { :git => 'https://github.com/SuperAwesomeLTD/sa-mobile-lib-ios-adloader.git', :tag => "0.1.3" }
  s.ios.deployment_target = '6.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SAAdLoader' => ['Pod/Assets/*.png']
  }
  s.dependency 'SAUtils'
  s.dependency 'SAJsonParser'
  s.dependency 'SAVASTParser'
end