//
//  SetViewController.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 7..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "SetViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface SetViewController ()

@end

@implementation SetViewController

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


#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"row";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    //[cell setAccessoryType:UITableViewCellAccessoryNone];
    
    return cell;
 
}
 */

#pragma mark - IBAction

- (IBAction)logout
{
    [[AppDelegate sharedDelegate] setAndStoreFlickrAuthToken:nil secret:nil];
    
    [self removeFromParentViewController];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
}

@end
