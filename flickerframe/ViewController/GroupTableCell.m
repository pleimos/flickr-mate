//
//  GroupTableCell.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 10..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "GroupTableCell.h"

@implementation GroupTableCell

@synthesize imageView, title, count;

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
