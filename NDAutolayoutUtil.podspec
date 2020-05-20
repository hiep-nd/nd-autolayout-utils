Pod::Spec.new do |spec|
spec.name         = "NDAutolayoutUtil"
  spec.version      = "0.0.1"
  spec.summary      = "A small library for autolayout."
  spec.description  = <<-DESC
  NDAutolayoutUtil is a small library for autolayout.
                   DESC
  spec.homepage     = "https://github.com/hiep-nd/nd-autolayout-util.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Nguyen Duc Hiep" => "hiep.nd@gmail.com" }
  spec.ios.deployment_target = '9.0'
  spec.tvos.deployment_target = '9.0'
  spec.swift_versions = ['4.0', '5.1', '5.2']
#  spec.source        = { :http => 'file:' + URI.escape(__dir__) + '/' }
  spec.source       = { :git => "https://github.com/hiep-nd/nd-autolayout-util.git", :tag => "Pod-#{spec.version}" }
  spec.source_files  = "NDAutolayoutUtil/**/*.{h,m,mm,swift}"
  spec.private_header_files = "NDAutolayoutUtil/Privates/**/*.{h}"
end
