Pod::Spec.new do |s|

  s.name             = "MaterialDesignIconsSwift"
  s.version          = "v4.2.0"
  s.summary          = "Use Material Design Icons font in Swift projects."
  s.homepage         = "https://github.com/bull-xu-stride/MaterialDesignIcons.Swift"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Bull Xu" => "bullx@stridesolutions.com.au" }
  s.source           = { :git => "https://github.com/bull-xu-stride/MaterialDesignIcons.Swift.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.source_files = 'MaterialDesignIconsSwift/*.{swift}'
  s.resource_bundle = { 'MaterialDesignIconsSwift' => 'MaterialDesignIconsSwift/*.ttf' }
  s.frameworks = 'UIKit', 'CoreText'

end
