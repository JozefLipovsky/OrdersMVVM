# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'OrdersMVVM' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for OrdersMVVM
  
  pod 'RealmSwift', '~> 1.0'
  pod 'Alamofire', '~> 3.4'
  pod 'AlamofireObjectMapper', '~> 3.0'
  pod 'AlamofireImage', '~> 2.4'
  

  target 'OrdersMVVMTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OrdersMVVMUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
          # Configure Pod targets for Xcode 8 compatibility
          config.build_settings['SWIFT_VERSION'] = '2.3'
          config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = 'B2328STN6B'
          config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
      end
  end
end
