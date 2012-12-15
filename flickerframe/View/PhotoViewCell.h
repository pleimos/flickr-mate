//
//  PhotoViewCell.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 15..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoThumbView.h"

@interface PhotoViewCell : UITableViewCell {
    IBOutlet PhotoThumbView *view1;
    IBOutlet PhotoThumbView *view2;
    IBOutlet PhotoThumbView *view3;
    IBOutlet PhotoThumbView *view4;
}

@property (retain, nonatomic) IBOutlet PhotoThumbView *view1;
@property (retain, nonatomic) IBOutlet PhotoThumbView *view2;
@property (retain, nonatomic) IBOutlet PhotoThumbView *view3;
@property (retain, nonatomic) IBOutlet PhotoThumbView *view4;


@end
