//
//  PhotoGroupView.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 15..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoGroupView : UIView {
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *titleView;
    IBOutlet UIView *checkerView;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *titleView;
@property (nonatomic, retain) UIView *checkerView;

@end
