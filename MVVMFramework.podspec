Pod::Spec.new do |s|
  s.name                  = 'MVVMFramework'
  s.version      = '0.0.7'
  s.summary               = 'MVVMFramework is a MVVM frameWork easy to develop iOS'
  s.homepage              = 'https://github.com/lovemo/MVVMFramework'
  s.platform     = :ios, '7.0'
  s.license               = 'MIT'
  s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
  s.source                = { :git => 'https://github.com/lovemo/MVVMFramework.git',:tag => '0.0.7' }
  s.requires_arc          = true
  s.public_header_files = 'SUIMVVM/**/*.h'
  s.source_files  = 'SUIMVVM/BQMVVM.h'
  s.framework             = 'CoreFoundation','Foundation','CoreGraphics','UIKit'
  s.library		= 'sqlite3'

  s.subspec 'Base' do |Base|
    Base.source_files = 'SUIMVVM/Base/**/*'
  end

  s.subspec 'ViewManger' do |ViewManger|
    ViewManger.source_files = 'SUIMVVM/Base/ViewManger/**/*'
  end

  s.subspec 'ViewModel' do |ViewModel|
    ViewModel.source_files = 'SUIMVVM/Base/ViewModel/**/*'
  end

  s.subspec 'Constant' do |Constant|
    Constant.source_files = 'SUIMVVM/Constant/**/*'
  end

  s.subspec 'Extend' do |Extend|
    Extend.source_files = 'SUIMVVM/Extend/**/*'
  end

  s.subspec 'Handler' do |Handler|
    Handler.source_files = 'SUIMVVM/Handler/**/*'
  end

  s.subspec 'MVVMCollectionDataDeleagte' do |MVVMCollectionDataDeleagte|
    MVVMCollectionDataDeleagte.source_files = 'SUIMVVM/Handler/MVVMCollectionDataDeleagte/**/*'
  end

  s.subspec 'MVVMTableDataDelegate' do |MVVMTableDataDelegate|
    MVVMTableDataDelegate.source_files = 'SUIMVVM/Handler/MVVMTableDataDelegate/**/*'
  end

  s.subspec 'Network' do |Network|
    Network.source_files = 'SUIMVVM/Network/**/*'
  end

  s.subspec 'Protocol' do |Protocol|
    Protocol.source_files = 'SUIMVVM/Protocol/**/*'
  end

  end
  s.subspec 'Store' do |Store|
    Store.source_files = 'SUIMVVM/Store/**/*'
  end

  s.subspec 'Vender' do |Vender|
    Vender.source_files = 'SUIMVVM/Vender/**/*'
  end

  s.subspec 'PMKVObserver' do |PMKVObserver|
    PMKVObserver.source_files = 'SUIMVVM/Vender/PMKVObserver/**/*'
  end
  s.subspec 'SUIUtils' do |SUIUtils|
    SUIUtils.source_files = 'SUIMVVM/Vender/SUIUtils/**/*'
  end
  s.subspec 'UITableView+FDTemplateLayoutCell' do |FDTemplateLayoutCell|
    FDTemplateLayoutCell.source_files = 'SUIMVVM/Vender/UITableView+FDTemplateLayoutCell/**/*'
  end
  s.subspec 'YTKKeyValueStore' do |YTKKeyValueStore|
    YTKKeyValueStore.source_files = 'SUIMVVM/Vender/YTKKeyValueStore/**/*'
  end

  s.subspec 'SUIMVVM' do |sp|
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
