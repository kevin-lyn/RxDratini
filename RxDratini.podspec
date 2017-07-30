Pod::Spec.new do |s|
  s.name = 'RxDratini'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'Dratini with RxSwift'
  s.homepage = 'https://github.com/kevin0571/RxDratini'
  s.authors = { 'Kevin Lin' => 'kevin_lyn@outlook.com' }
  s.source = { :git => 'https://github.com/kevin0571/RxDratini.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Sources/*.swift'
  s.dependency 'Dratini', '>= 1.1.0'
  s.dependency 'RxSwift', '>= 3.6.1'
end
