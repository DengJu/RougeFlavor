
Pod::Spec.new do |spec|

  spec.name         = "RougeFlavor"
  spec.version      = "1.0.5"
  spec.summary      = "oneselfGuess"
  spec.description  = "Network Request For MiMo."
  spec.homepage     = "https://github.com/DengJu/RougeFlavor/tree/1.0.0"
  spec.license      = "MIT"
  spec.author             = { "oneselfGuess" => "xebdison@163.com" }
  spec.platform     = :ios, "13.0"
  spec.swift_version = '5.0'
  spec.source       = { :git => "https://github.com/DengJu/RougeFlavor.git", :tag => "#{spec.version}" }
  spec.source_files  = "RougeFlavor", "RougeFlavor/**/*.{h,m,swift}"
  
end
