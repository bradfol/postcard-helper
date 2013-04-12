//
//  PostcardDelegate.h
//
//  Created by Brad Fol on 9/25/12.
//  Copyright (c) 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PCWorkflowControllerDelegate;
@protocol PostcardInfoViewDelegate;

@interface PostcardDelegate : UIResponder <PCWorkflowControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, PostcardInfoViewDelegate>

@property UIViewController* viewController;

-(id) initWithAPIKey:(NSString *)apiKey;
- (IBAction) showPostcardInfo;
- (IBAction) sendPostcard;

@end
