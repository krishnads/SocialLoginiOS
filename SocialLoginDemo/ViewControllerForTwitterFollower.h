//
//  ViewControllerForTwitterFollower.h
//  LoginWithTwitter
//
//  Created by Gaurav Taywade on 26/04/13.
//  Copyright (c) 2013 Gaurav taywade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewControllerForTwitterFollower : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSString *FriendType;

}
@property (nonatomic, strong) IBOutlet UITableView *TwitterFollowerListTableView;
@property (strong, nonatomic) NSArray *TwitterArray;
@property (nonatomic,strong) IBOutlet UILabel *titleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Friend_type:(NSString*)type;

- (IBAction)fnForBackButtonPressed:(id)sender;
- (void) gettwitterFollwers;
- (void) gettwitterFriends;
@end
