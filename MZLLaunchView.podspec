Pod::Spec.new do |s|

  s.name         = "MZLLaunchView"
  s.version      = "1.0.0"
  s.summary      = "Launch and Guide View Controller"
  s.homepage     = "https://github.com/mlijin9011/MZLLaunchView"
  s.license      = "MIT"
  s.author       = { "mlijin9011" => "mlijin9011@163.com" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/mlijin9011/MZLLaunchView.git", :tag => s.version.to_s}
  s.source_files = "MZLLaunchView", "MZLLaunchView/*.{h,m}"

end
