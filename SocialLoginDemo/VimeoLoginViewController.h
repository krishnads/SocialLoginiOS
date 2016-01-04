//
//  VimeoLoginViewController.h
//  SocialLoginDemo
//
//  Created by Krishana on 11/18/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAConsumer.h"
#import "OAToken.h"
#import "OAMutableURLRequest.h"
#import "OADataFetcher.h"

@interface VimeoLoginViewController : UIViewController <UIWebViewDelegate>
{
    
    IBOutlet UIWebView *WebView;
    OAConsumer* consumer;
    OAToken* requestToken;
    OAToken* accessToken;
}

-(void)connectTumblr;
@property(nonatomic,strong) IBOutlet UIWebView *WebView;


@end
