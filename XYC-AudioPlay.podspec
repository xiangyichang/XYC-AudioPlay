Pod::Spec.new do |s|
  s.name         = "XYC-AudioPlay"
  s.version      = "1.0.1"
  s.summary      = "音频播放音效播放"
  s.homepage     = "https://github.com/xiangyichang"
  s.license      = "MIT"
  s.authors      = { 'xiangyichang' => 'xiangyichang@163.com' }
  s.platform     = :ios, "7.0"
  s.source       = {:git => "https://github.com/xiangyichang/XYC-AudioPlay.git", :tag => s.version }
  s.source_files = '*.{h,m}'
  s.frameworks = 'MobileCoreServices'
end
