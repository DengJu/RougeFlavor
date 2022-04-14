
Pod::Spec.new do |spec|

  spec.name         = "RougeFlavor"
  spec.version      = "1.0.0"
  spec.summary      = "Network Request For MiMo."
  spec.description  = "Network Request For MiMo."
  spec.homepage     = "https://github.com/DengJu/RougeFlavor"
  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  spec.author             = { "oneselfGuess" => "xebdison@163.com" }
  spec.platform     = :ios, "13.0"
  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '5' }
  spec.source       = { :git => "https://github.com/DengJu/RougeFlavor.git", :tag => "#{spec.version}" }
  spec.source_files  = "RougeFlavor", "RougeFlavor/**/*.{h,m}"
  
end
