//
//  PhotoThumbView.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 15..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoThumbView : UIView {
    IBOutlet UIImageView *imageView;
    IBOutlet UIView *checkerView;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIView *checkerView;

@end
