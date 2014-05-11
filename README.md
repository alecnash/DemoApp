DemoApp
=======

CocoaPods are used so please use the DemoApp.xcworkspace to open the project.

CoreData is used and two 3rd party libraries (AFNetworking, JsonKit).

You may have two issues

1. You may need to install the cocoapods on the project. So go into the project's folder via terminal and type the following command:
pod install

2. If you get the following error: Pods-resources.sh: Permission denied
You need to make the script executable. Open terminal and execute this command:
chmod a+x .../Pods-resources.sh
