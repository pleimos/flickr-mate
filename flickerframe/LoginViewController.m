//
//  LoginViewController.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 10. 27..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MainViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize goLogin;
@synthesize flickrRequest;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)moveToMain
{
    MainViewController *mainViewController;
    mainViewController = (MainViewController *)[[self storyboard] instantiateViewControllerWithIdentifier:@"mainView"];
    [[self navigationController] setNavigationBarHidden:YES];
    [[self navigationController] pushViewController:mainViewController animated:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL loginCheck = YES;
    if( loginCheck == YES ){
        [self moveToMain];
    }
    return loginCheck;
}

- (void)selectionDidChange:(id<UITextInput>)textInput
{
    
}

- (void)selectionWillChange:(id<UITextInput>)textInput
{
    
}

- (void)textDidChange:(id<UITextInput>)textInput
{
    
}

- (void)textWillChange:(id<UITextInput>)textInput
{

    
    
}

- (IBAction)authorizeAction
{
    // if there's already OAuthToken, we want to reauthorize
    if ([[AppDelegate sharedDelegate].flickrContext.OAuthToken length]) {
        [[AppDelegate sharedDelegate] setAndStoreFlickrAuthToken:nil secret:nil];
    }
    
    self.flickrRequest.sessionInfo = @"kFetchRequestTokenStep";//kFetchRequestTokenStep;
    [self.flickrRequest fetchOAuthRequestTokenWithCallbackURL:[NSURL URLWithString:SRCallbackURLBaseString]];
}

#pragma mark OFFlickrAPIRequest delegate methods

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didObtainOAuthRequestToken:(NSString *)inRequestToken secret:(NSString *)inSecret
{
    // these two lines are important
    [AppDelegate sharedDelegate].flickrContext.OAuthToken = inRequestToken;
    [AppDelegate sharedDelegate].flickrContext.OAuthTokenSecret = inSecret;
    
    NSURL *authURL = [[AppDelegate sharedDelegate].flickrContext userAuthorizationURLWithRequestToken:inRequestToken requestedPermission:OFFlickrWritePermission];
    [[UIApplication sharedApplication] openURL:authURL];
}


#pragma mark Accesors

- (OFFlickrAPIRequest *)flickrRequest
{
    if (!flickrRequest) {
        flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:[AppDelegate sharedDelegate].flickrContext];
        flickrRequest.delegate = self;
		flickrRequest.requestTimeoutInterval = 60.0;
    }
    
    return flickrRequest;
}
@end
