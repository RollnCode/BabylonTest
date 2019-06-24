source 'https://github.com/CocoaPods/Specs'

platform :ios, '11.0'

use_frameworks!
inhibit_all_warnings!

def common_pods
	pod 'RxSwift'
	pod 'RxCocoa'
	pod 'Moya/RxSwift'
	pod 'SnapKit'
	pod 'RealmSwift'
	pod 'RxRealm'
end

def test_pods
	pod 'RxTest'
end

target 'BabylonTest' do
	project 'BabylonTest'
	common_pods

	target 'BabylonTestTests' do
		test_pods
        inherit! :search_paths
	end 

	target 'BabylonTestUITests' do
		common_pods 
		test_pods
		inherit! :search_paths
	end
end

