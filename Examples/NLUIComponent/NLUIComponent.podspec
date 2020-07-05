#
# Be sure to run `pod lib lint NLUIComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NLUIComponent'
  s.version          = '0.1.0'
  s.summary          = 'A short description of NLUIComponent.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/rakeyang/NLUIComponent'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rakeyang' => 'fenglaijun@gmail.com' }
  s.source           = { :git => 'https://github.com/rakeyang/NLUIComponent.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'NLUIComponent/Classes/**/*'
  s.prefix_header_contents = '#import <NLLogger/NLLogger.h>'

  # s.resource_bundles = {
  #   'NLUIComponent' => ['NLUIComponent/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MCUIKit', '~> 0.3'
  s.dependency 'Masonry', '~> 1.0'
  s.dependency 'MBProgressHUD', '~> 1.0.0'
  s.dependency 'SDWebImage', '5.8.0'
  s.dependency 'MJRefresh'
  s.dependency 'Toast'
  s.dependency 'NLLogger'
  s.dependency 'SnapKit', '~> 4.2'
end
