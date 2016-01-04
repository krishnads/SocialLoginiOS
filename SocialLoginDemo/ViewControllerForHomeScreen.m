//
//  ViewControllerForHomeScreen.m
//  FacebookLogin
//
//  Created by gaurav taywade on 24/04/13.
//  Copyright (c) 2012 www.oabstudios.com. All rights reserved.

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
// associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
// NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.#import <UIKit/UIKit.h>

#import "ViewControllerForHomeScreen.h"
@interface ViewControllerForHomeScreen ()

@end

@implementation ViewControllerForHomeScreen

@synthesize nameLabel;
@synthesize usernameLabel;
@synthesize profileImageView;
@synthesize followerLabel;
@synthesize FriendsLabel;

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
    [self.navigationController.navigationBar setHidden:YES];
    [self getProfileInfo];

}
#pragma mark - button pressed

- (IBAction)fnForLogOutButtonPressed:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)fnForShowFollowersButtonPressed:(id)sender
{
    ViewControllerForTwitterFollower_obj=[[ViewControllerForTwitterFollower alloc]initWithNibName:@"ViewControllerForTwitterFollower" bundle:nil Friend_type:@"Followers"];
    [self presentViewController:ViewControllerForTwitterFollower_obj animated:YES completion:nil];
}

- (IBAction)fnForShowFriendsButtonPressed:(id)sender
{
    ViewControllerForTwitterFollower_obj=[[ViewControllerForTwitterFollower alloc]initWithNibName:@"ViewControllerForTwitterFollower" bundle:nil Friend_type:@"Friends"];
    [self presentViewController:ViewControllerForTwitterFollower_obj animated:YES completion:nil];

}

#pragma mark - twitter info

- (void) getProfileInfo
{
    // Request access to the Twitter accounts
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
    {
        if (granted)
        {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            
            // Check if the users has setup at least one Twitter account
            
            if (accounts.count > 0)
            {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                
                // Creating a request to get the info about a user on Twitter
                // Pass exact username in parameter that we got at the time of login.
                
                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject:@"krisup01" forKey:@"screen_name"]];
                [twitterInfoRequest setAccount:twitterAccount];
                
                // Making the request
                
                [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        
                        if ([urlResponse statusCode] == 429) {
                            return;
                        }
                        
                        
                        if (error) {
                            return;
                        }
                        
                        // Check if there is some response data
                        
                        if (responseData) {
                            
                            NSError *error = nil;
                            NSArray *TweetArray = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                            
                          //  NSLog(@"%@",TweetArray);
                           
                            int followers = [[(NSDictionary *)TweetArray objectForKey:@"followers_count"] integerValue];
                            int following = [[(NSDictionary *)TweetArray objectForKey:@"friends_count"] integerValue];
                            
                            
                            NSURL *url = [NSURL URLWithString:[(NSDictionary *)TweetArray objectForKey:@"profile_image_url_https"]];
                            NSData *data = [NSData dataWithContentsOfURL:url];
                            profileImageView.image = [UIImage imageWithData:data];

                            
                            nameLabel.text = [NSString stringWithFormat:@"Name : %@",[(NSDictionary *)TweetArray objectForKey:@"name"]];
                            usernameLabel.text= [NSString stringWithFormat:@"@UserName :%@",[(NSDictionary *)TweetArray objectForKey:@"screen_name"]];
                            
                            followerLabel.text= [NSString stringWithFormat:@"Following : %i", following];
                            FriendsLabel.text = [NSString stringWithFormat:@"Followers : %i", followers];
                            
                        }
                    });
                }];
            }
        } else {
            NSLog(@"Access denied");
        }
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
