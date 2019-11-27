#
# Be sure to run `pod lib lint NLDataType.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NLDataType'
  s.version          = '0.1.0'
  s.summary          = 'A short description of NLDataType.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/rakeyang/NLDataType'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rakeyang' => 'fenglaijun@gmail.com' }
  s.source           = { :git => 'https://github.com/rakeyang/NLDataType.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'NLDataType/Classes/**/*'
  s.prefix_header_contents = '#import <NLLogger/NLLogger.h>'
  s.script_phase = { :name => '[Peregrine] Generator Routing Table', :script => 'export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    ruby ${PODS_ROOT}/Peregrine/Peregrine/PGGenerator.rb "${PODS_CONFIGURATION_BUILD_DIR}/Neverland.app/Peregrine.bundle"' }

  s.resource_bundles = {
    'NLDataType' => ['NLDataType/Assets/**']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
