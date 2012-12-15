//
//  PhotoThumbView.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 15..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "PhotoThumbView.h"

@implementation PhotoThumbView

@synthesize imageView, checkerView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super init];
    return self;
}

- (void)drawRect:(CGRect)rect
{
    checkerView.hidden = YES;
}

@end
