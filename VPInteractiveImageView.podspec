Pod::Spec.new do |s|
  s.name = "VPInteractiveImageView"
  s.version = "0.2.0"
  s.platform = :ios, '6.0'
  s.summary = "VPInteractiveImageView is a gesture based (Fullscreen) image display component as seen in iOS 7 Photos app or Facebook Paper"
  s.homepage = "https://github.com/vimacs/VPInteractiveImageViewController"
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { "Vidu Pirathaparajah" => "writetovidu@gmail.com" }
  s.source = { :git => "#{s.homepage}.git", :tag => "#{s.version}" }
  s.source_files = 'VPInteractiveImageViewController', 'VPInteractiveImageViewController/VPInteractiveImageViewController/VP*.{h,m}'
  s.requires_arc = true
end

