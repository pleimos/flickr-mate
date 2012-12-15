//
//  PhotoGroupView.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 15..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "PhotoGroupView.h"

@implementation PhotoGroupView

@synthesize imageView, titleView, checkerView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    checkerView.hidden = YES;
}

@end
