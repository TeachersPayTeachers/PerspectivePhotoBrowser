#
# Be sure to run `pod lib lint PerspectivePhotoBrowser.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PerspectivePhotoBrowser"
  s.version          = "0.1.0"
  s.summary          = "Native PhotoBrowser for ios"

  s.description      = "A unique photobrowser based on UICollectionView"

  s.homepage         = "https://github.com/teacherspayteachers/PerspectivePhotoBrowser"
  s.license          = 'MIT'
  s.author           = { "amol-c" => "chaudhari.amol.sopan@gmail.com", "jamesdo" => "james.s.do@gmail.com" }
  s.source           = { :git => "https://github.com/teacherspayteachers/PerspectivePhotoBrowser.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/TpTdotcom'

  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.swift_version = '4.1'

  s.source_files = 'Pod/Classes/**/*.{swift}'
  s.resource_bundles = {
    'PerspectivePhotoBrowser' => ['Pod/Assets/*.png']
  }
  s.resources = ["Pod/Resources/**/*.storyboard"]

  s.frameworks = 'UIKit'
  s.dependency 'SDWebImage', '~> 4.0'
end
