//
//  GPPLoginViewController.h
//  SocialLoginDemo
//
//  Created by Krishana on 11/18/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPPLoginViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *webview;
    NSMutableData *receivedData;
}

@property (nonatomic, retain) IBOutlet UIWebView *webview;
@property (nonatomic, retain) NSString *isLogin;
@property (assign, nonatomic) Boolean isReader;


@end
