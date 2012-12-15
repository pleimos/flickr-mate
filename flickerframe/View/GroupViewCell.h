//
//  GroupViewCell.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 15..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoGroupView.h"

@interface GroupViewCell : UITableViewCell{
    IBOutlet PhotoGroupView *view1;
    IBOutlet PhotoGroupView *view2;
}

@property (retain, nonatomic) IBOutlet PhotoGroupView *view1;
@property (retain, nonatomic) IBOutlet PhotoGroupView *view2;


@end
