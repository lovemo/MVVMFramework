Pod::Spec.new do |s|
  s.name                  = 'MVVMFramework'
  s.version      = '0.0.8'
  s.summary               = 'MVVMFramework is a MVVM frameWork easy to develop iOS'
  s.homepage              = 'https://github.com/lovemo/MVVMFramework'
  s.platform     = :ios, '7.0'
  s.license               = 'MIT'
  s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
  s.source                = { :git => 'https://github.com/lovemo/MVVMFramework.git',:tag => '0.0.8' }
  s.requires_arc          = true
  s.public_header_files = 'SUIMVVM/**/*.h'
  s.source_files  = 'SUIMVVM/BQMVVM.h'
  s.framework             = 'CoreFoundation','Foundation','CoreGraphics','UIKit'
  s.library		= 'sqlite3'

  s.subspec 'Base' do |base|
    base.source_files = 'SUIMVVM/Base/**/*'
  end

  s.subspec 'ViewManger' do |viewManger|
    viewManger.source_files = 'SUIMVVM/Base/ViewManger/**/*'
  end

  s.subspec 'ViewModel' do |viewModel|
    viewModel.source_files = 'SUIMVVM/Base/ViewModel/**/*'
  end

  s.subspec 'Constant' do |constant|
    constant.source_files = 'SUIMVVM/Constant/**/*'
  end

  s.subspec 'Extend' do |extend|
    extend.source_files = 'SUIMVVM/Extend/**/*'
  end

  s.subspec 'Handler' do |handler|
    handler.source_files = 'SUIMVVM/Handler/**/*'
  end

  s.subspec 'MVVMCollectionDataDeleagte' do |collection|
    collection.source_files = 'SUIMVVM/Handler/MVVMCollectionDataDeleagte/**/*'
  end

  s.subspec 'MVVMTableDataDelegate' do |table|
    table.source_files = 'SUIMVVM/Handler/MVVMTableDataDelegate/**/*'
  end

  s.subspec 'Network' do |network|
    network.source_files = 'SUIMVVM/Network/**/*'
  end

  s.subspec 'Protocol' do |protocol|
    protocol.source_files = 'SUIMVVM/Protocol/**/*'
  end

  s.subspec 'Store' do |store|
    store.source_files = 'SUIMVVM/Store/**/*'
  end

  s.subspec 'Vender' do |vender|
    vender.source_files = 'SUIMVVM/Vender/**/*'
  end

  s.subspec 'PMKVObserver' do |observer|
    observer.source_files = 'SUIMVVM/Vender/PMKVObserver/**/*'
  end
  s.subspec 'SUIUtils' do |sui|
    sui.source_files = 'SUIMVVM/Vender/SUIUtils/**/*'
  end
  s.subspec 'UITableView+FDTemplateLayoutCell' do |layoutCell|
    layoutCell.source_files = 'SUIMVVM/Vender/UITableView+FDTemplateLayoutCell/**/*'
  end
  s.subspec 'YTKKeyValueStore' do |kv|
    kv.source_files = 'SUIMVVM/Vender/YTKKeyValueStore/**/*'
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
