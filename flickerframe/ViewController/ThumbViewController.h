//
//  ThumbViewController.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 3..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGImageLoader.h"
#import "Photo.h"

@interface ThumbViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GGImageLoaderProtocol> {
    
    UICollectionView *thumbnailView;
    
    NSMutableArray *photoList;
}

@property (retain, nonatomic) IBOutlet UICollectionView *thunbnailView;

@property (retain, nonatomic) NSMutableArray *photoList;

- (void)loadImagesForOnscreenRows;

@end
