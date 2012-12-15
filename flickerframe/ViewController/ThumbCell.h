//
//  ThumbCell.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 3..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbCell : UICollectionViewCell {
    UIImageView *imageView;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
