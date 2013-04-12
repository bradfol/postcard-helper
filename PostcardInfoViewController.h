//
//  PostcardInfoViewController.h
//
//  Created by Brad Fol on 9/5/12.
//  Copyright (c) 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PostcardInfoViewDelegate;

@interface PostcardInfoViewController : UIViewController {}

@property (nonatomic, assign) id<PostcardInfoViewDelegate> delegate2;

- (IBAction)dismissView:(id)sender;

@end


@protocol PostcardInfoViewDelegate <NSObject>

-(void)dismissInfoView;

@end
