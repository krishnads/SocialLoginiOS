//
//  ViewController.h
//  SocialLoginDemo
//
//  Created by Krishana on 11/18/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <linkedin-sdk/LISDK.h>
#import "LiveConnectClient.h"

@interface ViewController : UIViewController<GIDSignInDelegate,GIDSignInUIDelegate,LiveAuthDelegate,LiveOperationDelegate>

@property (weak, nonatomic) IBOutlet UIButton *liveSignInBtn;

@property (nonatomic, retain) LiveConnectClient *liveClient;



@end

