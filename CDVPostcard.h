//
//  CDVPostcard.h
//
//  Created by Brad Fol on 11/12/12.
//  Copyright (c) 2013. All rights reserved.
//

#import <Cordova/CDVPlugin.h>

@interface CDVPostcard : CDVPlugin

-(void)startPostcardWithAPIkey:(CDVInvokedUrlCommand*)command;

@end
