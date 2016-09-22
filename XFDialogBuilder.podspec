Pod::Spec.new do |s|
s.name = 'XFDialogBuilder'
s.version = '1.2.9'
s.license = 'MIT'
s.summary = 'Configurable dialog for IOS.'
s.homepage = 'https://github.com/yizzuide/XFDialogBuilder'
s.authors = { 'yizzuide' => 'fu837014586@163.com' }
s.source = { :git => 'https://github.com/yizzuide/XFDialogBuilder.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '6.0'
s.source_files = 'XFDialogBuilder/**/*.{h,m}'
s.dependency 'pop'
end