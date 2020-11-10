Pod::Spec.new do |s|
  s.name         = "NDAutolayoutUtils"
  s.version      = "0.0.7"
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

  s.subspec 'Core' do |ss|
    ss.source_files  = "Sources/Core/*.{h,m,mm,swift}", "Sources/Core/Privates/*.{h,m,mm,swift}"
    ss.private_header_files = "Sources/Core/Privates/*.h"
    ss.framework = 'UIKit'
    ss.dependency 'NDLog', '~> 0.0.6'
    ss.dependency 'NDUtils/Foundation', '~> 0.0.5'
  end

  s.subspec 'ObjC' do |ss|
    ss.dependency 'NDAutolayoutUtils/Core'
  end

  s.subspec 'Swift' do |ss|
    ss.source_files  = "Sources/Swift/*.{h,m,mm,swift}"
    ss.dependency 'NDAutolayoutUtils/Core'
  end

  s.default_subspec = 'Swift'
end
