Pod::Spec.new do |s|

  s.name         = "HYNewFeatureView"
  s.version      = "1.0"
  s.summary      = "展示新特性界面"

  s.description  = <<-DESC
                    用于新版本首次启动时展示新特性界面
                   DESC

  s.homepage     = "https://github.com/xtyHY/HYNewFeatureView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "devhy" => "devhy@foxmail.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/xtyHY/HYNewFeatureView.git", :tag => "#{s.version}" }
  s.source_files  = "HYNewFeatureViewDemo/HYNewFeatureView/*.{h,m}"
  s.frameworks = "UIKit", "Foundation"
  s.requires_arc = true

end
