//
//  GPPLoginViewController.m
//  SocialLoginDemo
//
//  Created by Krishana on 11/18/15.
//  Copyright © 2015 Konstant Info Solutions Pvt. Ltd. All rights reserved.
//

#import "GPPLoginViewController.h"
#import "JSON.h"

NSString *gclient_id = @"282876432460-7stpujlbvb5fabbtlq2lptt4hmaichi5.apps.googleusercontent.com";;
NSString *gsecret = @"36mqNeoPTlqQn4UOqpbXIH1F";
NSString *gcallbakc =  @"http://www.konstantinfo.com";
NSString *gscope = @"https://www.googleapis.com/auth/userinfo.email+https://www.googleapis.com/auth/userinfo.profile+https://www.google.com/reader/api/0/subscription";
NSString *visibleactions = @"http://schemas.google.com/AddActivity";


@interface GPPLoginViewController ()

@end

@implementation GPPLoginViewController
@synthesize webview,isLogin,isReader;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSString *url = [NSString stringWithFormat:@"https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=%@&redirect_uri=%@&scope=%@&data-requestvisibleactions=%@",gclient_id,gcallbakc,gscope,visibleactions];
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    // [indicator startAnimating];
}


- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    //    [indicator startAnimating];
    if ([[[request URL] host] isEqualToString:@"www.konstantinfo.com"])
    {
        
        // Extract oauth_verifier from URL query
        NSString* verifier = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams)
        {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"code"])
            {
                verifier = [keyValue objectAtIndex:1];
                //NSLog(@"verifier %@",verifier);
                break;
            }
        }
        
        if (verifier)
        {
            NSString *data = [NSString stringWithFormat:@"code=%@&client_id=%@&client_secret=%@&redirect_uri=%@&grant_type=authorization_code", verifier,gclient_id,gsecret,gcallbakc];
            NSString *url = [NSString stringWithFormat:@"https://accounts.google.com/o/oauth2/token"];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
            //NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
            receivedData = [[NSMutableData alloc] init];
            
        }
        else
        {
            // ERROR!
        }
        
        [webView removeFromSuperview];
        
        return NO;
    }
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    [receivedData appendData:data];
    //NSLog(@"verifier %@",receivedData);
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", error]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *response = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    SBJsonParser *jResponse = [[SBJsonParser alloc]init];
    NSDictionary *tokenData = [jResponse objectWithString:response];
    //  WebServiceSocket *dconnection = [[WebServiceSocket alloc] init];
    //   dconnection.delegate = self;
    
    NSLog(@"response->%@",response);
    
    
    NSString *pdata = [NSString stringWithFormat:@"token=%@&login=%@", [tokenData objectForKey:@"access_token"], self.isLogin];
    NSLog(@"access token->%@",pdata);
    [self dismissViewControllerAnimated:true completion:^
     {
         NSString *msg = [NSString stringWithFormat:@"Your Access Token Is : \n %@",pdata];
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Successful." message:msg preferredStyle:UIAlertControllerStyleAlert];
         [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
         [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
         //[self presentViewController:alert animated:true completion:nil];
     }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
