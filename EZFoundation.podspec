#
#  Be sure to run `pod spec lint EZFoundation.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "EZFoundation"
    s.version      = "1.0"
    s.summary      = "EZFoundation is a bibrary for iOS project of Ezreal"
    s.description  = 'foundation...'
    
    s.homepage     = "https://github.com/Ezreal2852"
    s.license      = "MIT"
    s.author       = { "Ezreal" => "544881532@qq.com" }
    
    s.source       = { :git => "https://github.com/Ezreal2852/EZFoundation.git", :tag => s.version.to_s }
    
    s.platform     = :ios, "10.0"
    s.swift_version = "5.0"
    
    s.subspec "EZFoundation" do |ss|
    
    # extension
    ss.subspec "extension" do |sss|
    sss.source_files = "EZFoundation/extension/*.{h,m,swift}"
    end
    
    end
    
    end
    