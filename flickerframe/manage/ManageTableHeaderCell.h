//
//  ManageTableHeaderCell.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 12. 8..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageTableHeaderCell : UITableViewCell {
    char titleType;
    IBOutlet UILabel *titleText;
    
    IBOutlet UIButton *btnAdd;
    IBOutlet UIButton *btnEdit;
}

@property (strong, nonatomic) UILabel *titleText;
@property char titleType;

- (IBAction)addPhoto:(id)sender;
- (IBAction)editPhotos:(id)sender;

@end
