#
# Be sure to run `pod lib lint PureSwiftLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PureSwiftLib'
  s.version          = '0.1.0'
  s.summary          = 'A short description of PureSwiftLib.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Rake Yang/PureSwiftLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rake Yang' => 'fenglaijun@gmail.com' }
  s.source           = { :git => 'https://github.com/Rake Yang/PureSwiftLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'PureSwiftLib/Classes/**/*'
  s.static_framework = true
  s.swift_version = "5.0"

  s.pod_target_xcconfig = { "DEFINES_MODULE" => "YES" }
  
  s.private_header_files = 'PureSwiftLib/Classes/Dependency.h'

#  s.dependency 'WechatOpenSDK'
  s.dependency 'PureObjCLib'
  s.dependency 'YYCategories'
  
  s.prefix_header_contents = <<-EOS
    #import <YYCategories/YYCategories.h>
  EOS

end
