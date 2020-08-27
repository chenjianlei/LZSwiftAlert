
Pod::Spec.new do |s|
  s.name             = 'LZSwiftAlert'
  s.version          = '0.0.1'
  s.summary          = 'LZSwiftAlert.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/chenjianlei/LZSwiftAlert'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenjianlei' => 'woshixiaolei@qq.com' }
  s.source           = { :git => 'https://github.com/chenjianlei/LZSwiftAlert.git', :tag => s.version.to_s }

  s.swift_version = "4.2"
  s.swift_versions = ['4.0', '4.2', '5.0']
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'LZSwiftAlert/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LZSwiftAlert' => ['LZSwiftAlert/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.framework = 'UIKit'
   s.dependency 'MBProgressHUD', '1.2.0'
end
