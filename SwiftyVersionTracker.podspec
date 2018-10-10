Pod::Spec.new do |s|
  s.name             = "SwiftyVersionTracker"
  s.version          = "4.2.0"
  s.summary          = "With SwiftyVersionTracker, you can track which versions previously installed. Convenient methods are also available."
  s.homepage         = "https://github.com/notohiro/SwiftyVersionTracker"
  s.license          = 'MIT'
  s.author           = { "Hiroshi Noto" => "notohiro@gmail.com" }
  s.source           = { :git => "https://github.com/notohiro/SwiftyVersionTracker.git", :tag => s.version.to_s }

  s.platform         = :ios, '8.0'
  s.swift_version    = '4.2'

  s.requires_arc     = true
  s.source_files     = 'SwiftyVersionTracker/*'
end
