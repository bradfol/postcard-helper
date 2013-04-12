//
//  PostcardInfoViewController.m
//
//  Created by Brad Fol on 9/5/12.
//  Copyright (c) 2013. All rights reserved.
//

#import "PostcardInfoViewController.h"

@interface PostcardInfoViewController ()

@end

@implementation PostcardInfoViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

//    [(UIScrollView *)self.view setContentSize:CGSizeMake(320, 580)]; //set size of contents in scroll view
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)dismissView:(id)sender {
    [self.delegate2 dismissInfoView];
//    [self dismissModalViewControllerAnimated:YES];
}

@end
