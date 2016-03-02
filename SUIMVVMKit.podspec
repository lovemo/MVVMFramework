Pod::Spec.new do |s|
    s.name                  = 'SUIMVVMKit'
    s.version      = '0.1.3'
    s.summary               = 'SUIMVVMKit is a MVVM frameWork easy to develop iOS'
    s.homepage              = 'https://github.com/lovemo/MVVMFramework'
    s.platform     = :ios, '7.0'
    s.license               = 'MIT'
    s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
    s.source                = { :git => 'https://github.com/lovemo/MVVMFramework.git',:tag => '0.1.3' }
    s.requires_arc          = true
    s.public_header_files = 'SUIMVVMKit/**/*.h'
    s.source_files  = 'SUIMVVMKit/SUIMVVMKit.h'
    s.framework             = 'CoreFoundation','Foundation','CoreGraphics','UIKit'

    s.subspec 'Vender' do |ss|
    ss.requires_arc = true
    ss.source_files = 'SUIMVVMKit/Vender/**/*'
    ss.public_header_files = 'SUIMVVMKit/Vender/**/*.h'
    end

    s.subspec 'SUIMVVMKit' do |ss|
    ss.requires_arc = true
    ss.dependency 'MJRefresh'
    ss.dependency 'SVProgressHUD'
    ss.dependency 'FDFullscreenPopGesture'
    ss.dependency 'MJExtension'
    ss.dependency 'SDWebImage'
    ss.dependency 'LxDBAnything'
    ss.dependency 'Masonry'
    ss.dependency 'SUIMVVMNetwork'
    ss.dependency 'SUIMVVMStore'
    ss.dependency 'SUIMVVMKit/Vender'
    ss.source_files = 'SUIMVVMKit/*.{h,m}'
    ss.public_header_files = 'SUIMVVMKit/**/*.h'
    end

end
