#
# Be sure to run `pod lib lint LithoUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LithoUtils'
  s.version          = '0.1.0'
  s.summary          = 'A library of helper methods, focused on common operations that occur in iOS development.'
  s.swift_versions = ['4.0', '4.1', '4.2', '5.0', '5.1', '5.2', '5.3']

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
LithoUtils gives developers a library of shortcuts, streamlining the common operations that occur in iOS development and allowing developers to focus on whatever makes their project unique. Examples include UIViewController functions returning a closure to push or present another UIViewController onto it, functions that bind publishers to arbitrary properties of UI elements, and helper methods that help differentiate the iOS environment the developer is developing on.
                       DESC

  s.homepage         = 'https://github.com/ThryvInc/litho-utils'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lithobyte' => '' }
  s.source           = { :git => 'https://github.com/ThryvInc/litho-utils.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'LithoUtils/Classes/**/*'
  s.dependency 'LithoOperators'
  
  s.subspec 'Core' do |sp|
      sp.ios.deployment_target = '11.0'
      sp.dependency 'fuikit'
      sp.source_files = 'LithoUtils/Classes/Base/**/*.swift'
  end
end
