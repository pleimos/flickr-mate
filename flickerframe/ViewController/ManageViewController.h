//
//  ManageViewController.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 7..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbCell.h"

@interface ManageViewController : UITableViewController <UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

{
    
}

- (IBAction)goSet:(id)sender;
- (IBAction)goPhoto:(id)sender;

@end
