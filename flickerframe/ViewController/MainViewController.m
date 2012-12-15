//
//  MainViewController.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 10. 27..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize contentViewController, menuViewController;

- (id)init
{

    //IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.contentViewController leftViewController:self.menuViewController];
    
    //IIViewDeckController* deckController = [self initWithCenterViewController:self.contentViewController leftViewController:self.menuViewController];
    
    //[self addChildViewController:deckController];
 
    
//    self.rightLedge = 100;
    
    
    //self.window.rootViewController = deckController;
    return self;
}

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
    
    self.menuViewController = (MenuViewController *)[[self storyboard] instantiateViewControllerWithIdentifier:@"menuView"];
    self.contentViewController = (ContentViewController *)[[self storyboard] instantiateViewControllerWithIdentifier:@"contentView"];
    UIViewController *menuView = [[UIViewController alloc] init];
    [menuView.view setBackgroundColor:[UIColor redColor]];
    UIViewController *contentView = [[UIViewController alloc] init];
    [contentView.view setBackgroundColor:[UIColor blueColor]];
    
    [self initWithCenterViewController:self.contentViewController leftViewController:self.menuViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
