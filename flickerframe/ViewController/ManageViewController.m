//
//  ManageViewController.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 7..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "ManageViewController.h"

@interface ManageViewController ()

@end

@implementation ManageViewController

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

- (void)goPhoto:(id)sender
{
    [self performSegueWithIdentifier:@"photoSegue" sender:sender];
}

- (void)goSet:(id)sender
{
    [self performSegueWithIdentifier:@"setSegue" sender:sender];    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows;
    
    if( section == 3 ){
        rows = 1;
    } else {
        rows = 1;
    }
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 3 ){
        return 100.0f;
    } else {
        return 63.0f;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *imageTextCellIdentifier = @"imageTextCell";
    static NSString *photoCellIdentifier = @"photoCell";
    static NSString *readyCellIdentifier = @"readyCell";
    
    NSString *CellIdentifier;
    
    UITableViewCell *cell;
    if( indexPath.section == 3){
        CellIdentifier = photoCellIdentifier;
    } else if( indexPath.section == 1){
        CellIdentifier = readyCellIdentifier;
    } else {
        CellIdentifier = imageTextCellIdentifier;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    //[cell setAccessoryType:UITableViewCellAccessoryNone];
    
    
    
    NSString *menuName = @"";
    if( indexPath.section == 0 ){
        menuName = @"홈";
    } else if( indexPath.section == 1 ){
        menuName = @"슬라이드 관리";
    } else if( indexPath.section == 2 ){
        menuName = @"설정";
    } else {
        menuName = @"???????";
    }
    //cell.textLabel.text = menuName;
    
    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"test %i", section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 3 ){
        [self performSegueWithIdentifier:@"photoSegue" sender:nil];
        
    } else {
        [self performSegueWithIdentifier:@"setSegue" sender:nil];
    }
}


#pragma mark - Collection view data source


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"ThumbCell";
    ThumbCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier1 forIndexPath:indexPath];
    
    // Configure the cell...
    if( cell == nil ){
    }
    cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"123");
}


@end
