//
//  Manage2ViewController.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 15..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "Manage2ViewController.h"
#import "ManageTableHeaderCell.h"

@interface Manage2ViewController ()

@end

@implementation Manage2ViewController

@synthesize tableView;

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
	// Do any additional setup after loading the
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //[self navigationController].navigationBar.alpha = 0.5f;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 0 ){
        return 80.0f;
    } else {
        return 80.0f;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"제목";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    /*
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 320, 40)];
    title.text = @"제목";
    title.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    [headerView addSubview:title];
    
    UIButton *btnEdit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnEdit.frame = CGRectMake(265, 7, 50, 30);
    btnEdit.titleLabel.text = @"Edit";
    btnEdit.titleLabel.textColor = [UIColor blackColor];
    [headerView addSubview:btnEdit];

    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAdd.frame = CGRectMake(210, 7, 50, 30);
    btnAdd.titleLabel.text = @"Add";
    btnAdd.titleLabel.textColor = [UIColor blackColor];
    [headerView addSubview:btnAdd];
     
     return headerView;
     */
    
    static NSString *sectionHeaderCellIdentifier = @"sectionHeader";
    ManageTableHeaderCell *cell = (ManageTableHeaderCell *)[self.tableView dequeueReusableCellWithIdentifier:sectionHeaderCellIdentifier];
    if (cell == nil){
        [NSException raise:@"cell == nil.." format:@"No cells with matching CellIdentifier loaded from interface builder"];
    }
    
    if( section == 0 ){
        cell.titleText.text = @"세트";
        cell.titleType = section;
    } else {
        cell.titleText.text = @"사진";
        cell.titleType = section;
    
    }
    
    return (UIView *)cell;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *photoCellIdentifier = @"photoCell";
    static NSString *groupCellIdentifier = @"groupCell";
    
    
    if( indexPath.section == 0 ){
        GroupViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:groupCellIdentifier];
        if (cell == nil) {
            cell = [[GroupViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:groupCellIdentifier];
        }
        
        cell.view1.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        cell.view2.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        cell.view1.titleView.text = @"그룹이름";
        if( indexPath.row == 3 )
        {
            [cell.view2 setHidden:YES];
        } else {
            [cell.view2 setHidden:NO];
        }
        return cell;
    } else {
        
        PhotoViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:photoCellIdentifier];
        if (cell == nil) {
            cell = [[PhotoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:photoCellIdentifier];
        }
        
        cell.view1.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        cell.view2.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        cell.view3.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        cell.view4.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        return cell;
    }
    
}


@end
