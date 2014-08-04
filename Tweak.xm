#import <UIKit/UIKit.h>
#import "substrate.h"

@interface AVCameraViewController: UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	UIView *_cameraOverlay;
}
-(void)buttonMethod;
@end

%hook AVCameraViewController

- (void)viewDidLoad {
	%orig;
	
	UIView *cameraOverlay = MSHookIvar<UIView *>(self,"_cameraOverlay");
	
	UIImage *btnImage = [UIImage imageWithContentsOfFile:@"/Library/Application Support/SnapSelect/snapselect.png"];
	int btnHeight = btnImage.size.height;
	int btnWidth = btnImage.size.width;
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.frame = CGRectMake(60.0, 435.0 ,btnWidth, btnHeight);
	[btn setImage:btnImage forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchDown];
	[cameraOverlay addSubview:btn];
	
}

%new 
-(void)showPicker {
	UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    imagePickController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickController.delegate= self;
    imagePickController.allowsEditing=NO;
    [self presentModalViewController:imagePickController animated:YES];
    [imagePickController release];
	
}

%end
