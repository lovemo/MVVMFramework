Pod::Spec.new do |s|
    s.name                  = 'SUIMVVMKit'
    s.version      = '0.1.1'
    s.summary               = 'SUIMVVMKit is a MVVM frameWork easy to develop iOS'
    s.homepage              = 'https://github.com/lovemo/MVVMFramework'
    s.platform     = :ios, '7.0'
    s.license               = 'MIT'
    s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
    s.source                = { :git => 'https://github.com/lovemo/MVVMFramework.git',:tag => '0.1.1' }
    s.requires_arc          = true
    s.public_header_files = 'SUIMVVMKit/**/*.h'
    s.source_files  = 'SUIMVVMKit/SUIMVVMKit.h'
    s.framework             = 'CoreFoundation','Foundation','CoreGraphics','UIKit'
    s.library		= 'sqlite3'

    s.subspec 'SUIMVVMKit' do |ss|
    ss.requires_arc = true
    ss.dependency 'MJRefresh'
    ss.dependency 'AFNetworking'
    ss.dependency 'SVProgressHUD'
    ss.dependency 'FDFullscreenPopGesture'
    ss.dependency 'MJExtension'
    ss.dependency 'SDWebImage'
    ss.dependency 'FMDB'
    ss.dependency 'LxDBAnything'
    ss.dependency 'Masonry'
    ss.source_files = '*.{h,m,mm}','SUIMVVMKit/**/*.{h,m,mm}'
    ss.public_header_files = 'SUIMVVMKit/**/*.h'
    end

end
