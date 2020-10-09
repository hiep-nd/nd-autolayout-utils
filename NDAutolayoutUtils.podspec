Pod::Spec.new do |s|
  s.name         = "NDAutolayoutUtils"
  s.version      = "0.0.6"
  s.summary      = "A small library for autolayout."
  s.description  = <<-DESC
  NDAutolayoutUtils is a small library for autolayout.
                   DESC
  s.homepage     = "https://github.com/hiep-nd/nd-autolayout-utils.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Nguyen Duc Hiep" => "hiep.nd@gmail.com" }
  s.ios.deployment_target = '9.0'
#  s.tvos.deployment_target = '9.0'
  s.swift_versions = ['4.0', '5.1', '5.2']
  s.requires_arc   = true
#  s.source        = { :http => 'file:' + URI.escape(__dir__) + '/' }
  s.source       = { :git => "https://github.com/hiep-nd/nd-autolayout-utils.git", :tag => "Pod-#{s.version}" }

  s.source_files  = "NDAutolayoutUtils/**/*.{h,m,mm}"
  s.public_header_files = 'NDAutolayoutUtils/*.h'
  s.framework = 'UIKit'
  
  s.dependency 'NDLog', '~> 0.0.5'
  s.dependency 'NDUtils/Foundation', '~> 0.0.4'
end
