//
//  ContentViewController.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 10. 28..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

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
    [self makeTabBarHidden:YES];
    
    [self loadManageView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadHomeView
{
    self.selectedIndex = 0;
}

- (void)loadManageView
{
    self.selectedIndex = 1;
}

- (void)loadConfigView
{
    self.selectedIndex = 2;
}

- (void)makeTabBarHidden:(BOOL)hide { // Custom code to hide TabBar
    
    if ( [self.view.subviews count] < 2 ) { return; }
    
    
    
    UIView *contentView;
    
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ) {
        
        contentView = [self.view.subviews objectAtIndex:1];
        
    } else {
        
        contentView = [self.view.subviews objectAtIndex:0];
        
    }
    
    
    
    if (hide) {
        
        contentView.frame = self.view.bounds;
        
    } else {
        
        contentView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height - self.tabBar.frame.size.height);
        
    }
    
    
    
    self.tabBar.hidden = hide;
    
}

@end
