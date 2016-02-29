Pod::Spec.new do |s|
  s.name                  = "MVVMFramework"
  s.version               = “0.0.1”
  s.summary               = "MVVMFramework is a MVVM frameWork easy to develop iOS”
  s.homepage              = "https://github.com/lovemo/MVVMFramework"
  s.platform     = :ios,’7.0’
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { “love” => “lovemomoyulin@qq.com” }
  s.source                = { :git => "https://github.com/lovemo/MVVMFramework.git",:tag => “0.0.1” }
  s.ios.deployment_target = “7.0”
  s.requires_arc          = true
  s.framework             = "CoreFoundation","Foundation","CoreGraphics","UIKit"
  s.library		= "sqlite3"
  s.subspec 'SUIMVVM' do |sp|
    sp.source_files = '*.{h,m,mm}','SUIMVVM/**/*.{h,m,mm}'
    sp.requires_arc = true
	pod 'MJRefresh', '> 3.0.0'
	pod 'AFNetworking', '>= 3.0'
	pod 'SVProgressHUD'
	pod 'FDFullscreenPopGesture'
	pod 'MJExtension'
	pod 'SDWebImage'
	pod 'FMDB'
	pod 'LxDBAnything'
	pod 'Masonry'
	pod 'SUIUtils', :git => 'https://github.com/randomprocess/SUIUtils' 
  end
end
