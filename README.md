# iOSGuide
iOS重要知识点介绍、演示

## 打包命令
```ruby
xcodebuild -workspace Example/MCLogger.xcworkspace -scheme MCLogger-Example -sdk iphoneos11.3 -configuration Release -archivePath ./build/MCLogger-Example clean archive build
xcodebuild -exportArchive -archivePath ./build/MCLogger-Example.xcarchive -exportOptionsPlist ./build/exportOptionsPlist.plist -exportPath ./build
```
