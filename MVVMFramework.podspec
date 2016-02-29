Pod::Spec.new do |s|
  s.name                  = 'MVVMFramework'
  s.version      = '0.0.2'
  s.summary               = 'MVVMFramework is a MVVM frameWork easy to develop iOS'
  s.homepage              = 'https://github.com/lovemo/MVVMFramework'
  s.platform     = :ios, '7.0'
  s.license               = 'MIT'
  s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
  s.source                = { :git => 'https://github.com/lovemo/MVVMFramework.git',:tag => '0.0.2' }
  s.requires_arc          = true
  s.public_header_files = 'SUIMVVM/**/*.h'
  s.framework             = 'CoreFoundation','Foundation','CoreGraphics','UIKit'
  s.library		= 'sqlite3'
  s.subspec 'SUIMVVM' do |sp|
    sp.source_files = 'SUIMVVM/**/*.{h,m,mm}'
    sp.requires_arc = true
    sp.dependency 'MJRefresh'
    sp.dependency 'AFNetworking'
    sp.dependency 'SVProgressHUD'
    sp.dependency 'FDFullscreenPopGesture'
    sp.dependency 'MJExtension'
    sp.dependency 'SDWebImage'
    sp.dependency 'FMDB'
    sp.dependency 'LxDBAnything'
    sp.dependency 'Masonry'

   # sp.dependency 'SUIUtils',  :git => 'https://github.com/randomprocess/SUIUtils.git'

  end
end
