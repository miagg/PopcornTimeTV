use_frameworks!

source 'https://github.com/CocoaPods/Specs'
source 'https://github.com/PopcornTimeTV/Specs'

def pods
#    pod 'PopcornTorrent', :git => 'https://github.com/portellaa/PopcornTorrent' #, '~> 1.3.16'
#    pod 'PopcornTorrent', '~> 1.3.0'
#    pod 'PopcornTorrent',  :path => 'PopcornTorrent.podspec'#, '~> 1.3.16'
#    pod 'XCDYouTubeKit', '~> 2.15.2'
#    pod 'XCDYouTubeKit', :git => 'https://github.com/hinge-agency/XCDYouTubeKit.git', :branch => 'fix/issue-534-XCDYouTubeVideoErrorDomain-error-code-3'
#    pod 'Alamofire', '~> 4.9.0'
#    pod 'AlamofireImage', '~> 3.5.0'
#    pod 'FloatRatingView', '~> 3.0.1'
#    pod 'ObjectMapper', '~> 3.5.0'
end

target 'PopcornTimeiOS' do
    platform :ios, '14.5'
    pods
#    pod 'AlamofireNetworkActivityIndicator', '~> 2.4.0'
    pod 'google-cast-sdk', '~> 4.4'
    pod 'OBSlider', '~> 1.1.1'
    pod 'MobileVLCKit', '~> 3.3.16'
end

target 'PopcornTimetvOS' do
    platform :tvos, '14.5'
    pods
    pod 'TVVLCKit', '~> 3.3.16'
#    pod 'MBCircularProgressBar', '~> 0.3.5-1'
end

target 'PopcornTimetvOS SwiftUI' do
    platform :tvos, '14.5'
    pods
    pod 'TVVLCKit', '~> 3.3.16'
end

target 'TopShelf' do
    platform :tvos, '14.5'
#    pod 'ObjectMapper', '~> 3.5.0'
end

def kitPods
#    pod 'Alamofire', '~> 4.9.0'
#    pod 'ObjectMapper', '~> 3.5.0'
#    pod 'SwiftyJSON', '~> 5.0.0'
#    pod 'Locksmith', '~> 4.0.0'
end

# target 'PopcornKit tvOS' do
#     platform :tvos, '14.5'
#     kitPods
# end
#
# target 'PopcornKit iOS' do
#     platform :ios, '14.5'
#     kitPods
#     pod 'google-cast-sdk', '~> 4.4'
# end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        end
        if ['FloatRatingView-iOS', 'FloatRatingView-tvOS'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
    
#    installer.pods_project.build_configurations.each do |config|
#        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
#    end
end
