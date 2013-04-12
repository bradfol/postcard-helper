//
//  PostcardDelegate.m
//
//  Created by Brad Fol on 9/25/12.
//  Copyright (c) 2013. All rights reserved.
//

#import "PostcardDelegate.h"
#import "PostcardInfoViewController.h"
#import <POTR/POTR.h>

@interface PostcardDelegate ()

@property (nonatomic, retain) PCWorkflowController *postcardsWorkflowController;
@property UIViewController *postcardsViewController;
@property UINavigationController* navController;

@end

@implementation PostcardDelegate

@synthesize postcardsWorkflowController, viewController;

-(id)initWithAPIKey:(NSString *)apiKey {
    postcardsWorkflowController = [[PCWorkflowController alloc] initWithAPIKey:apiKey];
    postcardsWorkflowController.delegate = self;
    
    return self;
}

- (IBAction) showPostcardInfo {
    PostcardInfoViewController* postcardInfo = [[PostcardInfoViewController alloc] initWithNibName:@"PostcardInfoViewController" bundle:nil];
    postcardInfo.delegate2 = self;
    
    self.navController= [[UINavigationController alloc] initWithRootViewController:postcardInfo];
    [self.navController navigationBar].topItem.title= @"Info";
    UIBarButtonItem* cancelButton= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self.navController action:@selector(dismissModalViewControllerAnimated:)];
    [[self.navController navigationBar].topItem setLeftBarButtonItem:cancelButton];
    
    [self.viewController presentModalViewController:self.navController animated:YES];
}

- (void)dismissInfoView{
    [self sendPostcard];
}

- (IBAction) sendPostcard {
    BOOL has_camera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL has_gallery = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    if(has_camera && has_gallery){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Select a Photo Source"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"Camera", @"Gallery", nil];
        
        // Show the sheet
        [sheet showInView:self.navController.view];
    }
    else if(has_camera){
        [self sendPostcardWith:UIImagePickerControllerSourceTypeCamera];
    }
    else if(has_gallery){
        [self sendPostcardWith:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"No Camera or Photo Albums Unavailable", @"")
                              message:NSLocalizedString(@"There is no camera or photos available on your device. This means there is nothing to send a postcard with.", @"")
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Okay", @"")
                              otherButtonTitles:nil
                              ];
        
        [alert show];
    }
}

- (void) sendPostcardWith:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    
    controller.sourceType = type;
    controller.delegate = self;
    controller.allowsEditing = NO;
    
    [self.navController presentModalViewController:controller animated:YES];
}

#pragma mark PostCardDelegate

- (BOOL) allowPhotoEditing {
    return YES;
}

- (BOOL) allowPhotoFraming {
    return YES;
}

- (BOOL) allowSmellMail {
    return YES;
}

- (BOOL) allowStatisticsGathering {
    return YES;
}

- (BOOL) showCancelButton {
    return YES;
}

- (UIColor *) tintColor {
    return [UIColor blackColor];
}

- (BOOL) useLocationServices {
    return YES;
}

- (void) potr:(UIViewController *)potr canceled:(BOOL)canceled {
    [viewController dismissModalViewControllerAnimated:YES];
    
    if(!canceled){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success, Your Postcard Has Been Sent!", @"") message:NSLocalizedString(@"Your postcard has been uploaded and will be sent by USPS 1st class mail. Please check your email for an order confirmation.", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alert show];
    }
}

- (NSString *) promoCode{
    return @"";
}


#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    PCWorkflowController *pcController = [appDelegate postcardsController];
    
    PCPhoto *photo = [[PCPhoto alloc] initWithUIImage:(UIImage *)[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    
    self.postcardsViewController = [postcardsWorkflowController viewControllerForPhoto:photo];
    
    [picker dismissModalViewControllerAnimated:YES];
    
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:postcardsViewController];
    
    [self.navController pushViewController:self.postcardsViewController animated:YES];
//    viewController.sentViewController= navController;
}


#pragma mark UIActionSheetDelegate

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 2){
        return;
    }
    
    if(buttonIndex){
        [self sendPostcardWith:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else{
        [self sendPostcardWith:UIImagePickerControllerSourceTypeCamera];
    }
}


@end
