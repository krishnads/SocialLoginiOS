//
//  ViewController.m
//  SocialLoginDemo
//
//  Created by Krishana on 11/18/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerForHomeScreen.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "YahooSDK.h"

NSString *microClientID = @"0000000040176183";
NSString *microClientSecret = @"ds41Eg7fcJ6wF72YbOPFfCuQ4ur74Z1q";

@interface ViewController () <YahooSessionDelegate>

@property (strong, nonatomic) YahooSession *session;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
    //self.FBloginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////


#pragma mark: - Google Plus SignIN
-(IBAction)gppLoginAction:(id)sender
{
    GIDSignIn *gppSignIn = [GIDSignIn sharedInstance];
    
    gppSignIn.uiDelegate = self;
    gppSignIn.delegate = self;
    gppSignIn.shouldFetchBasicProfile = true;
    gppSignIn.shouldFetchBasicProfile = true;
    gppSignIn.allowsSignInWithWebView = true;
    gppSignIn.allowsSignInWithBrowser = true;
    gppSignIn.scopes = [NSArray arrayWithObject:@"https://www.googleapis.com/auth/plus.login"];
    gppSignIn.clientID = @"282876432460-p4omfmqdjpu6tqhk4gc912ma0gq877te.apps.googleusercontent.com";

    // Uncomment to automatically sign in the user.
    [gppSignIn signIn];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////


#pragma mark: - Facebook Login Action
-(IBAction)facebookLoginAction:(id)sender
{
    
//    @"public_profile",@"user_friends",@"email",@"user_about_me",@"user_actions.books",@"user_actions.fitness",@"user_actions.music",@"user_actions.news",@"user_actions.video",@"user_birthday",@"user_education_history",@"user_events",@"user_games_activity",@"user_hometown",@"user_likes",@"user_location",@"user_managed_groups",@"user_photos",@"user_posts",@"user_relationships",@"user_relationship_details",@"user_religion_politics",@"user_tagged_places",@"user_videos",@"user_website",@"user_work_history",@"read_custom_friendlists",@"read_insights",@"read_audience_network_insights",@"read_page_mailboxes",@"manage_pages",@"publish_pages",@"publish_actions",@"rsvp_event",@"pages_show_list",@"pages_manage_cta",@"pages_manage_leads",@"ads_read",@"ads_management"
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         UIAlertController *alert;
         if (error)
         {
             NSLog(@"Process error");
             alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Error in Login" preferredStyle:UIAlertControllerStyleAlert];
         }
         else if (result.isCancelled)
         {
             alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Cancelled by user" preferredStyle:UIAlertControllerStyleAlert];

             NSLog(@"Cancelled");
         }
         else
         {
             alert = [UIAlertController alertControllerWithTitle:@"Logged In with Access Token" message:result.token.tokenString preferredStyle:UIAlertControllerStyleAlert];

             NSLog(@"Logged in->%@",result.token.tokenString);
             [self fetchDataFromFacebook];
             
         }
         [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alert animated:true completion:nil];
     }];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

-(void) fetchDataFromFacebook
{
    //["fields": "id, name, gender"]
    //@"id",@"name",@"first_name",@"last_name",@"age_range",@"link",@"gender",@"locale",@"timezone",@"updated_time",@"verified"
    
    NSDictionary *paradic = [[NSDictionary alloc] initWithObjects:@[@"id,name,first_name,last_name,age_range,link,gender,locale,timezone,updated_time,verified"] forKeys:@[@"fields"]];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:paradic]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
    {
         if (!error)
         {
             NSLog(@"fetched user:%@", result);
         }
     }];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////


#pragma mark: - Twitter Login Action
-(IBAction)tWitterLoginAction:(id)sender
{
    ViewControllerForHomeScreen *ViewControllerForHomeScreen_obj=[[ViewControllerForHomeScreen alloc]initWithNibName:@"ViewControllerForHomeScreen" bundle:nil];
    [self.navigationController pushViewController:ViewControllerForHomeScreen_obj animated:YES];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////


- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    // Perform any operations on signed in user here.
//    NSString *userId = user.userID;                  // For client-side use only!
//    NSString *idToken = user.authentication.idToken; // Safe to send to the server
//    NSString *name = user.profile.name;
//    NSString *email = user.profile.email;
    // ...
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    // Perform any operations when the user disconnects from app here.
    // ...
}

- (IBAction)didTapSignOut:(id)sender
{
    [[GIDSignIn sharedInstance] signOut];
}


// Implement these methods only if the GIDSignInUIDelegate is not a subclass of
// UIViewController.

// Stop the UIActivityIndicatorView animation that was started when the user
// pressed the Sign In button
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
   // [myActivityIndicator stopAnimating];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController
{
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark: - LinkedIN SignIn Action

-(IBAction)linkedInLoginAction:(id)sender
{
    [LISDKSessionManager createSessionWithAuth:[NSArray arrayWithObjects:LISDK_BASIC_PROFILE_PERMISSION, nil] state:nil showGoToAppStoreDialog:YES successBlock:^(NSString *returnState)
     {
         NSLog(@"%s","success called!");
         //[self getUserInfoFromLinkedIn];
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Successful." message:@"You have successfully logged in via LinkedIn" preferredStyle:UIAlertControllerStyleAlert];
         [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alert animated:true completion:nil];
        // LISDKSession *session = [[LISDKSessionManager sharedInstance] session];
     }
     errorBlock:^(NSError *error)
     {
         NSLog(@"%s","error called!");
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Error in Login" preferredStyle:UIAlertControllerStyleAlert];
         [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [self presentViewController:alert animated:true completion:nil];
     }
     ];
}

#pragma mark: - Getting User Profile from LinkedIn
-(void) getUserInfoFromLinkedIn
{
    NSString *url = @"https://api.linkedin.com/v1/people/~";
    
    if ([LISDKSessionManager hasValidSession])
    {
        [[LISDKAPIHelper sharedInstance] getRequest:url success:^(LISDKAPIResponse *response)
        {
            // do something with response
            NSLog(@"response->%@",response.description);
        }
        error:^(LISDKAPIError *apiError)
        {
            // do something with error
        }];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Yahoo Login Action

-(IBAction)yahooLoginAction:(id)sender
{
    [self createYahooSession];
}

#pragma mark - YahooSessionDelegate

- (void)didReceiveAuthorization
{
    
    [self createYahooSession];
}

#pragma mark - YOSUserRequestDelegate

// Waiting to fetch response
- (void)requestDidFinishLoading:(YOSResponseData *)data
{
    
    // Get the JSON response, will exist ONLY if requested response is JSON
    // If JSON does not exist, use data.responseText for NSString response
    NSDictionary *json = data.responseJSONDict;
    
    // Profile fetched
    NSDictionary *userProfile = json[@"profile"];
    if (userProfile)
    {
        NSLog(@"User profile fetched->%@",userProfile);
        
        NSString *msg = [NSString stringWithFormat:@"Name : %@\nNickName : %@\nLocation : %@\nProfile URL : %@",[userProfile objectForKey:@"givenName"],[userProfile objectForKey:@"nickname"],[userProfile objectForKey:@"location"],[userProfile objectForKey:@"profileUrl"]];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Successful" message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }
    // Contacts fetched
    NSDictionary *contactDict = json[@"contacts"];
    if (contactDict)
    {
        NSLog(@"Contact list fetched");
        //NSArray *contactList = [YOSUserRequest parseContactList:contactDict];
        //NSArray *parsedContactList = [YOSUserRequest parseContactListForNameOnly:contactList];
        //[self.contactViewController loadContactList:parsedContactList];
    }
    // YQL query response fetched
    NSDictionary *yqlDict = json[@"query"];
    if (yqlDict) {
        NSDictionary *yqlResults = yqlDict[@"results"];
        NSLog(@"%@",yqlResults);
    }
}

#pragma mark - Public methods

- (void)logout
{
    [self.session clearSession];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createYahooSession
{
    // Create session with consumer key, secret and application id
    // Set up a new app here: https://developer.yahoo.com/dashboard/createKey.html
    // The default values here won't work
    self.session = [YahooSession sessionWithConsumerKey:@"dj0yJmk9YVo4elIzV0pyV29XJmQ9WVdrOWVGWnBhMnB2TldFbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD02ZA--"
                                      andConsumerSecret:@"1b806fbb3af5919864291915a46fa69151f8e0d6"
                                       andApplicationId:@"SocialDemo"
                                         andCallbackUrl:@"http://www.konstantinfo.com"
                                            andDelegate:self];
    
    BOOL hasSession = [self.session resumeSession];
    NSLog(@"has session->%i",hasSession);
    
    if(!hasSession)
    {
        // Not logged-in, send login and authorization pages to user
        [self.session sendUserToAuthorization];
    }
    else
    {
        // Logged-in, send requests
        NSLog(@"Session detected!");
       // [self sendUserContactsRequest];
        [self sendUserProfileRequest];
       // [self pushContactListToVC];
        // [self sendASyncYQLRequests];
        // [self sendSyncYQLRequests];
    }
}

- (void)sendUserProfileRequest
{
    // Initialize profile request
    YOSUserRequest *userRequest = [YOSUserRequest requestWithSession:self.session];
    
    // Fetch user profile
    [userRequest fetchProfileWithDelegate:self];
}

- (void)sendUserContactsRequest
{
    // Initialize contact list request
    YOSUserRequest *request = [YOSUserRequest requestWithSession:self.session];
    
    // Fetch the user's contact list
    [request fetchContactsWithStart:0 andCount:300 withDelegate:self];
}

- (void)sendASyncYQLRequests
{
    // Initialize YQL request
    YQLQueryRequest *request = [YQLQueryRequest requestWithSession:self.session];
    
    // Build YQL query string
    NSString *structuredYQLQuery = [NSString stringWithFormat:@"select * from social.profile where guid = me"];
    
    // Fetch YQL response
    [request query:structuredYQLQuery withDelegate:self];
}

- (void)sendSyncYQLRequests
{
    YQLQueryRequest *request = [YQLQueryRequest requestWithSession:self.session];
    
    NSString *structuredLocationQuery = [NSString stringWithFormat:@"select * from geo.places where text=\"sfo\""];
    
    YOSResponseData *data = [request query:structuredLocationQuery];
    NSDictionary *json = data.responseJSONDict;
    NSDictionary *queryData = json[@"query"];
    NSDictionary *results = queryData[@"results"];
    
    NSLog(@"%@", results);
}

#pragma YAHOO! implementation ends here

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma Mark: - Microsoft Live Login Action Starts

-(IBAction)microsoftLoginAction:(id)sender
{
    if (self.liveClient.session == nil)
    {
        [self configureLiveClientWithScopes:@"wl.signin wl.basic wl.skydrive wl.postal_addresses wl.phone_numbers wl.emails"];
    }
    else
    {
        [self micrologout];
    }
}

#pragma mark - Auth methods

- (void) configureLiveClientWithScopes:(NSString *)scopeText
{
    self.liveClient = [[LiveConnectClient alloc] initWithClientId:microClientID
                                                            scopes:[scopeText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                                                          delegate:self
                                                         userState:@"init"];
    [self loginWithScopes:@"wl.signin wl.basic wl.skydrive wl.postal_addresses wl.phone_numbers wl.emails"];
}

- (void) loginWithScopes:(NSString *)scopeText
{
    @try
    {
        NSArray *scopes = [scopeText componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [_liveClient login:self scopes:scopes delegate:self userState:@"login"];
    }
    @catch(id ex)
    {
        [self handleException:ex context:@"loginWithScopes"];
    }
}

#pragma Auth Delegate Method

-(void)authCompleted:(LiveConnectSessionStatus)status session:(LiveConnectSession *)session userState:(id)userState
{
    [self updateSignInButton:session.userId];
    NSLog(@"Session Info->%@",session.userId);
}

- (void) micrologout
{
    @try
    {
        [_liveClient logoutWithDelegate:self userState:@"logout"];
    }
    @catch(id ex)
    {
        [self handleException:ex context:@"logout"];
    }
}

- (void) updateSignInButton : (NSString *)userID
{
    LiveConnectSession *session = self.liveClient.session;
    if (session == nil)
    {
        [self.liveSignInBtn setTitle:@"MICROSOFT SignIn" forState:UIControlStateNormal];
    }
    else
    {
        [self.liveSignInBtn setTitle:@"Sign out from MICROSOFT" forState:UIControlStateNormal];
        [self getLiveProfileDetail:userID];
    }
}

#pragma mark - Output handling
- (void) handleException:(id)exception
                 context:(NSString *)context
{
    NSLog(@"Exception received. Context: %@", context);
    NSLog(@"Exception detail: %@", exception);
}

- (void) handleError:(NSError *)error
             context:(NSString *)context
{
    NSLog(@"Error received. Context: %@", context);
    NSLog(@"Error detail: %@", error);
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)getLiveProfileDetail: (NSString *)userId
{
    //[self.liveClient getWithPath:userId delegate:self userState:@"getMe"];
    
    [self.liveClient getWithPath:@"me" delegate:self userState:@"getMe"];
    
   // [self.liveClient getWithPath:@"me/friends" delegate:self userState:@"getFriends"];
}

- (void) liveOperationSucceeded:(LiveOperation *)operation
{
    if ([operation.userState isEqual:@"getMe"])
    {
        NSLog(@"result->%@",operation.result.description);
        
        NSMutableString *msg= [NSMutableString stringWithFormat:@"Email : %@\nName: %@\nID : %@\nLink : %@",[[operation.result objectForKey:@"emails"] objectForKey:@"account"],[operation.result objectForKey:@"first_name"],[operation.result objectForKey:@"id"],[operation.result objectForKey:@"link"]] ;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Successful with following credentials..." message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (void) liveOperationFailed:(NSError *)error operation:(LiveOperation *)operation
{
    if ([operation.userState isEqual:@"getMe"])
    {
        NSLog(@"error->%@",operation.result);
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
