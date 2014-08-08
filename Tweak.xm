#import <UIKit/UIKit.h>
#import "substrate.h" // Needed for MSHookIvar to work

@interface AVCameraViewController: UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	UIView *_cameraOverlay; // Declares the UIView we are going to hook
	// This is known because I dumped the SnapChat app headers and found this.
}
@end

//This is all to define whether the position of the icon is correct.
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )
// Thanks to Macmade@stackexchange for these macros.

%hook AVCameraViewController

- (void)viewDidLoad {
	%orig; // Call the original method implementations (VERY IMPORTANT)
	
	// Hook the view we want to add a button to.
	UIView *cameraOverlay = MSHookIvar<UIView *>(self,"_cameraOverlay");
	
	// Get the image for the button
	UIImage *btnImage = [UIImage imageWithContentsOfFile:@"/Library/Application Support/SnapSelect/snapselect.png"];
	int btnHeight = btnImage.size.height; // Get the dimensions of the image to make the button the correct size.
	int btnWidth = btnImage.size.width;
	
	// Create the button
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	btn.frame = CGRectMake(60.0, IS_IPHONE_5 ? 530.0 : 435.0 , btnWidth, btnHeight); // Comparison to get the correct height
	[btn setImage:btnImage forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchDown];
	[cameraOverlay addSubview:btn]; // Add the button to the view that was hooked earlier
	
}

%new 
-(void)showPicker {
	// Create an UIImagePickerController
	UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    imagePickController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickController.delegate= self;
    imagePickController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary]; 
    imagePickController.allowsEditing=NO;
    [self presentModalViewController:imagePickController animated:YES];
    [imagePickController release];
	
}

// See the readme as to why there isn't more code needed than this.

%end

// Fix for the crashing on Snapchat v7.0.5
%hook PreviewViewController

- (void)sendSnapWithSendViewRequired:(BOOL)arg1 {
	%orig(YES);
}

%end
