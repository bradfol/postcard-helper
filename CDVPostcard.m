//
//  CDVPostcard.m
//
//  Created by Brad Fol on 11/12/12.
//  Copyright (c) 2013. All rights reserved.
//

#import "CDVPostcard.h"
#import "PostcardDelegate.h"

@interface CDVPostcard ()

@property PostcardDelegate* postcardDelegate;

@end

@implementation CDVPostcard

-(void)startPostcardWithAPIkey:(CDVInvokedUrlCommand*)command {
    
    CDVPluginResult* pluginResult = nil;
    NSString* myarg = [command.arguments objectAtIndex:0];
    
    if (myarg != nil && [myarg length] != 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        self.postcardDelegate= [[PostcardDelegate alloc] initWithAPIKey:myarg];
        self.postcardDelegate.viewController= self.viewController;
        
        [self.postcardDelegate showPostcardInfo];
        NSLog(@"Starting POTR with API key: %@",myarg);
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Need an API key for POTR."];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

@end
