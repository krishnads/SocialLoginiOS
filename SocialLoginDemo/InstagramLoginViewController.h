//
//  InstagramLoginViewController.h
//  SocialLoginDemo
//
//  Created by Krishana on 11/18/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthConsumer.h"

@interface InstagramLoginViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webview;
    OAConsumer* consumer;
    OAToken* requestToken;
    OAToken* accessToken;
    NSMutableData *receivedData;
}
@property (nonatomic, retain) IBOutlet UIWebView *webview;
//@property (nonatomic, retain) IBOutlet TapazineLoadingIndicator *indicator;
@property (nonatomic, retain) NSString *isLogin;
@property (assign, nonatomic) Boolean isReader;


@end
