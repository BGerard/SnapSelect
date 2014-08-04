SnapSelect
==========

This is a small modification that allows you to send photos from your photo library via SnapChat.

How It Works
============
I initially thought this concept was going to require a lot more work then it actually did. This is because I originally thought I would have to get the UIImage from an UIImagePickerController created by myself and then use this to spoof the UIImage usually sent via the SnapChat application. However, it turns out the UIImagePickerController integrates seemlessly into SnapsChats already existing code, I can only assume this is because SnapChat themselves use something similar to UIImagePickerControllerSourceTypeCamera. After all, the UIImagePickerControllerDelegate is already implemented within SnapChat. This means that I only have to create my own UIImagePickerController and SnapChats exisiting methods to handle the media will work perfectly. This reduced my need to reverse engineer the application more to create a hacky method to spoof the applications parameters. 

All of the information I needed for this modification was gained purely through header dumps. From these I realised that when the application starts the MainViewController is displayed, from here more views are created in order to create the swipe to change view effect within the SnapChat app. Obviously I was interested in the view that had the camera element known as "_middleVC" this led me to the views, view controller "AVCameraViewController", it then obviously made sence to hook the camera overlay view and create my button.

I have commented my code as fully as possible in order for people to learn.
