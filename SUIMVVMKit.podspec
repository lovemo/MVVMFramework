Pod::Spec.new do |s|
    s.name                  = 'SUIMVVMKit'
    s.version      = '0.2.9'
    s.summary               = 'SUIMVVMKit is a MVVM frameWork easy to develop iOS'
    s.homepage              = 'https://github.com/lovemo/MVVMFramework'
    s.platform     = :ios, '7.0'
    s.license               = 'MIT'
    s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
    s.source                = { :git => 'https://github.com/lovemo/MVVMFramework.git',:tag => '0.2.9' }
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
    ss.dependency 'SUIMVVMStore'
    ss.dependency 'SUIMVVMNetwork'
    ss.dependency 'SUIMVVMKit/Vender'
    ss.source_files = 'SUIMVVMKit/SUIMVVMKit/**/*'
    ss.public_header_files = 'SUIMVVMKit/SUIMVVMKit/**/*.h'
    end

end
