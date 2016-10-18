# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'QTest' do
  # Uncomment this line if you're using Swift or would like to use dynamic frameworks
   use_frameworks!

  # Pods for QTest
    pod 'MBProgressHUD', '~> 1.0.0'
    pod 'TSMessages', :git => 'https://github.com/KrauseFx/TSMessages.git'
    pod 'MFSideMenu'
#    pod 'PNChart'
    pod 'IQKeyboardManager'
    pod 'AFNetworking', '~> 3.0'
    pod 'Charts'

end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3' # or '3.0'
        end
    end
end
