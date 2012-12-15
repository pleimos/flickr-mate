//
//  RootViewController.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 10. 28..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"

NSString *kFetchRequestTokenStep = @"kFetchRequestTokenStep";
NSString *kGetUserInfoStep = @"kGetUserInfoStep";
NSString *kSetImagePropertiesStep = @"kSetImagePropertiesStep";
NSString *kUploadImageStep = @"kUploadImageStep";

@interface RootViewController (PrivateMethods)
- (void)updateUserInterface:(NSNotification *)notification;
- (void)logoutInterface:(NSNotification *)notification;

@end

@implementation RootViewController

@synthesize isLogged;
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
    if ([[AppDelegate sharedDelegate].flickrContext.OAuthToken length]) {
		//authorizeButton.enabled = NO;
        NSLog(@"asdasd");
	}
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInterface:) name:SnapAndRunShouldUpdateAuthInfoNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutInterface:) name:@"logout" object:nil];


}

- (void)viewWillAppear:(BOOL)animated
{
    self.isLogged = NO;

    /*
    if( self.isLogged == YES ){
        [self moveToMain];
    } else {
        [self moveToLogin];
    }
     */

    
	[self updateUserInterface:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)moveToLogin
{
    LoginViewController *loginViewController;
    loginViewController = (LoginViewController *)[[self storyboard] instantiateViewControllerWithIdentifier:@"loginView"];
    [self pushViewController:loginViewController animated:YES];
}

- (void)moveToMain
{
    MainViewController *mainViewController;
    mainViewController = (MainViewController *)[[self storyboard] instantiateViewControllerWithIdentifier:@"mainView"];
    [self setNavigationBarHidden:YES];
    [self pushViewController:mainViewController animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"loginSegue"])
    {
        
        //LoginViewController *loginViewController = [[LoginViewController alloc] init];
        //self._window.RootViewController = loginViewController;
        //self.view
        
    } else if ([[segue identifier] isEqualToString:@"mainSegue"])
    {
        //MainViewController *mainViewController = [[MainViewController alloc] init];
        //self.window.RootViewController = mainViewController;
    }
}
- (void)logoutInterface:(NSNotification *)notification
{
    LoginViewController *loginViewController;
    loginViewController = (LoginViewController *)[[self storyboard] instantiateViewControllerWithIdentifier:@"loginView"];
//    [self pushViewController:loginViewController animated:YES];
    
    NSArray *viewControllers = [NSArray arrayWithObject:loginViewController];
    
    [self setViewControllers:viewControllers animated:YES];
    //[self moveToLogin];
}

- (void)updateUserInterface:(NSNotification *)notification
{
    self.isLogged = NO;
    
    /*
     if( self.isLogged == YES ){
     [self moveToMain];
     } else {
     [self moveToLogin];
     }
     */
    
	if ([[AppDelegate sharedDelegate].flickrContext.OAuthToken length]) {
		if ([[AppDelegate sharedDelegate].flickrUserName length]) {
			NSString *temp = [NSString stringWithFormat:@"You are %@", [AppDelegate sharedDelegate].flickrUserName];
            NSLog(@"%@", temp);
		}
		else {
			NSLog(@"You've logged in");
		}
        [self moveToMain];
        
	}
	else {
		NSLog(@"Login to Flickr");
        [self moveToLogin];
	}
	
	if ([self.flickrRequest isRunning]) {
        /*
		[snapPictureButton setTitle:@"Cancel" forState:UIControlStateNormal];
		[snapPictureButton setTitle:@"Cancel" forState:UIControlStateHighlighted];
		[snapPictureButton setTitle:@"Cancel" forState:UIControlStateDisabled];
		authorizeButton.enabled = NO;
         */
	}
	else {
        /*
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
			[snapPictureButton setTitle:@"Snap" forState:UIControlStateNormal];
			[snapPictureButton setTitle:@"Snap" forState:UIControlStateHighlighted];
			[snapPictureButton setTitle:@"Snap" forState:UIControlStateDisabled];
			snapPictureDescriptionLabel.text = @"Use camera";
		}
		else {
			[snapPictureButton setTitle:@"Pick Picture" forState:UIControlStateNormal];
			[snapPictureButton setTitle:@"Pick Picture" forState:UIControlStateHighlighted];
			[snapPictureButton setTitle:@"Pick Picture" forState:UIControlStateDisabled];
			snapPictureDescriptionLabel.text = @"Pick from library";
		}
		
		authorizeButton.enabled = YES;
         */
	}
}

# pragma mark -
# pragma mark Flickr

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didObtainOAuthRequestToken:(NSString *)inRequestToken secret:(NSString *)inSecret
{
    // these two lines are important
    [AppDelegate sharedDelegate].flickrContext.OAuthToken = inRequestToken;
    [AppDelegate sharedDelegate].flickrContext.OAuthTokenSecret = inSecret;
    
    NSURL *authURL = [[AppDelegate sharedDelegate].flickrContext userAuthorizationURLWithRequestToken:inRequestToken requestedPermission:OFFlickrWritePermission];
    [[UIApplication sharedApplication] openURL:authURL];
}
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
    NSLog(@"%s %@ %@", __PRETTY_FUNCTION__, inRequest.sessionInfo, inResponseDictionary);
    
	if (inRequest.sessionInfo == kUploadImageStep) {
		//snapPictureDescriptionLabel.text = @"Setting properties...";
        
        
        NSLog(@"%@", inResponseDictionary);
        NSString *photoID = [[inResponseDictionary valueForKeyPath:@"photoid"] textContent];
        
        flickrRequest.sessionInfo = kSetImagePropertiesStep;
        [flickrRequest callAPIMethodWithPOST:@"flickr.photos.setMeta" arguments:[NSDictionary dictionaryWithObjectsAndKeys:photoID, @"photo_id", @"Snap and Run", @"title", @"Uploaded from my iPhone/iPod Touch", @"description", nil]];
	}
    else if (inRequest.sessionInfo == kSetImagePropertiesStep) {
		//[self updateUserInterface:nil];
		//snapPictureDescriptionLabel.text = @"Done";
        
		[UIApplication sharedApplication].idleTimerDisabled = NO;
        
    }
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError
{
    NSLog(@"%s %@ %@", __PRETTY_FUNCTION__, inRequest.sessionInfo, inError);
	if (inRequest.sessionInfo == kUploadImageStep) {
		//[self updateUserInterface:nil];
		//snapPictureDescriptionLabel.text = @"Failed";
		[UIApplication sharedApplication].idleTimerDisabled = NO;
        
		[[[UIAlertView alloc] initWithTitle:@"API Failed" message:[inError description] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
        
	}
	else {
		[[[UIAlertView alloc] initWithTitle:@"API Failed" message:[inError description] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
	}
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
