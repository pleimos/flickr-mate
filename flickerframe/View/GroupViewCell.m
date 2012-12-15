//
//  GroupViewCell.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 15..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "GroupViewCell.h"

@implementation GroupViewCell

@synthesize view1, view2;

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

@end
