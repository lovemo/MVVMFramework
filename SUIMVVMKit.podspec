Pod::Spec.new do |s|
    s.name                  = 'SUIMVVMKit'
    s.version      = '0.1.0'
    s.summary               = 'SUIMVVMKit is a MVVM frameWork easy to develop iOS'
    s.homepage              = 'https://github.com/lovemo/MVVMFramework'
    s.platform     = :ios, '7.0'
    s.license               = 'MIT'
    s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
    s.source                = { :git => 'https://github.com/lovemo/MVVMFramework.git',:tag => '0.1.0' }
    s.requires_arc          = true
    s.public_header_files = 'SUIMVVMKit/**/*.h'
    s.source_files  = 'SUIMVVMKit/SUIMVVMKit.h'
    s.framework             = 'CoreFoundation','Foundation','CoreGraphics','UIKit'
    s.library		= 'sqlite3'


    s.subspec 'Protocol' do |ss|
    ss.source_files = 'SUIMVVMKit/Protocol/*.{h,m}'
    ss.public_header_files = 'SUIMVVMKit/Protocol/**/*.h'
    end

    s.subspec 'ViewManger' do |ss|
    ss.dependency 'SUIMVVMKit/Protocol'
    ss.source_files = 'SUIMVVMKit/Base/ViewManger/*.{h,m}'
    end

    s.subspec 'Base' do |ss|
    ss.source_files = 'SUIMVVMKit/Base/*.{h,m}'
    end

    s.subspec 'ViewModel' do |ss|
    ss.source_files = 'SUIMVVMKit/Base/ViewModel/*.{h,m}'
    end

    s.subspec 'Constant' do |ss|
    ss.source_files = 'SUIMVVMKit/Constant/*.{h,m}'
    end

    s.subspec 'Extend' do |ss|
    ss.source_files = 'SUIMVVMKit/Extend/*.{h,m}'
    end

    s.subspec 'Handler' do |ss|
    ss.source_files = 'SUIMVVMKit/Handler/*.{h,m}'
    end

    s.subspec 'MVVMCollectionDataDeleagte' do |ss|
    ss.dependency 'SUIMVVMKit/Extend'
    ss.source_files = 'SUIMVVMKit/Handler/MVVMCollectionDataDeleagte/*.{h,m}'
    end

    s.subspec 'MVVMTableDataDelegate' do |ss|
    ss.dependency 'SUIMVVMKit/Extend'
    ss.source_files = 'SUIMVVMKit/Handler/MVVMTableDataDelegate/*.{h,m}'
    end

    s.subspec 'Network' do |ss|
    ss.dependency 'AFNetworking'
    ss.source_files = 'SUIMVVMKit/Network/*.{h,m}'
    end

    s.subspec 'Vender' do |ss|
    ss.requires_arc = true
    ss.dependency 'MJRefresh'
    ss.dependency 'SVProgressHUD'
    ss.dependency 'FDFullscreenPopGesture'
    ss.dependency 'MJExtension'
    ss.dependency 'SDWebImage'
    ss.dependency 'LxDBAnything'
    ss.dependency 'Masonry'
    ss.source_files = 'SUIMVVMKit/Vender/**/*'
    end

    s.subspec 'YTKKeyValueStore' do |ss|
    ss.dependency 'FMDB'
    ss.source_files = 'SUIMVVMKit/Vender/YTKKeyValueStore/*.{h,m}'
    end

    s.subspec 'PMKVObserver' do |ss|
    ss.source_files = 'SUIMVVMKit/Vender/PMKVObserver/*.{h,m}'
    end

    s.subspec 'UITableView+FDTemplateLayoutCell' do |ss|
    ss.source_files = 'SUIMVVMKit/Vender/UITableView+FDTemplateLayoutCell/*.{h,m}'
    end

    s.subspec 'SUIUtils' do |ss|
#  ss.dependency 'SUIMVVMKit/Vender/UITableView+FDTemplateLayoutCell'
    ss.source_files = 'SUIMVVMKit/Vender/SUIUtils/**/*'
    end

    s.subspec 'Store' do |ss|
#   ss.dependency 'SUIMVVMKit/Vender/YTKKeyValueStore'
    ss.source_files = 'SUIMVVMKit/Store/*.{h,m}'
    end

end
