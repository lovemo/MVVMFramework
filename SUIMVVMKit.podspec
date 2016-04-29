Pod::Spec.new do |s|

s.name                  = 'SUIMVVMKit'
s.version      = '0.5.2'
s.summary               = 'SUIMVVMKit is a MVVM frameWork easy to develop iOS'
s.homepage              = 'https://github.com/lovemo/MVVMFramework'
s.platform     = :ios, '7.0'
s.license               = 'MIT'
s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
s.source                = { :git => 'https://github.com/lovemo/MVVMFramework.git',:tag => s.version.to_s }
s.requires_arc          = true
s.public_header_files = 'SUIMVVMKit/**/*.h'
s.source_files  = 'SUIMVVMKit/SUIMVVMKit.h'
s.frameworks             = 'CoreFoundation','Foundation','UIKit'

s.subspec 'SUIMVVMKit' do |ss|
ss.requires_arc = true
ss.library = 'sqlite3'
ss.dependency 'AFNetworking'
ss.dependency 'FMDB'
ss.dependency 'SUIUtils'
ss.source_files = 'SUIMVVMKit/SUIMVVMKit/**/*'
ss.public_header_files = 'SUIMVVMKit/SUIMVVMKit/**/*.h'
end

end
