//
//  GroupTableCell.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 10..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupTableCell : UITableViewCell {
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *title;
    IBOutlet UILabel *count;
}

@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *count;


@end
