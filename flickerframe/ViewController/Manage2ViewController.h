//
//  Manage2ViewController.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 15..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewCell.h"
#import "GroupViewCell.h"

@interface Manage2ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UITableView *tableView;
}

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
