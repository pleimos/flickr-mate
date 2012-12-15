//
//  ManageTableHeaderCell.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 12. 8..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "ManageTableHeaderCell.h"

@implementation ManageTableHeaderCell

@synthesize titleType, titleText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


# pragma mark - user

- (void)addPhoto:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%c", self.titleType);
}

- (void)editPhotos:(id)sender
{
    
}

@end
