platform :ios, '14.0'
use_frameworks!

# Workspace
workspace 'TMDB'

# Core
def core_pods
  pod 'Swinject'
end

target 'Core' do
  project 'Core/Core.xcproject'

  core_pods
end

# Data
def data_pods
  pod 'TEQNetwork', :git => 'https://github.com/Teqnological-Asia/TEQNetwork.git'
  pod 'Amplify'
  pod 'AmplifyPlugins/AWSCognitoAuthPlugin'
  pod 'Moya'
end

target 'Data' do
  project 'Data/Data.xcproject'

  core_pods
  data_pods
end

# Domain
target 'Domain' do
  project 'Domain/Domain.xcproject'

  core_pods
end

# DashboardTab
target 'DashboardTab' do
  project 'DashboardTab/DashboardTab.xcproject'

  core_pods
end

# SearchMovie
target 'SearchMovie' do
  project 'SearchMovie/SearchMovie.xcproject'

  core_pods
end

# Resources
def resources_pods
  pod 'SDWebImageSwiftUI'
end

target 'Resources' do
  project 'Resources/Resources.xcproject'
  resources_pods
end

# App
target 'App' do
  project 'App/App.xcproject'

  core_pods
  data_pods
  resources_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

