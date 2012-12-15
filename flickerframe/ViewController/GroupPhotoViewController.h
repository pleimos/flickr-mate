//
//  GroupPhotoViewController.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 7..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectiveFlickr.h"
#import "PhotoSet.h"
#import "GGImageLoader.h"

@interface GroupPhotoViewController : UIViewController <UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, OFFlickrAPIRequestDelegate,
    UIScrollViewDelegate, GGImageLoaderProtocol>
{
    PhotoSet *photoSet;
    OFFlickrAPIRequest *flickrRequest;
    NSMutableArray *photoList;
    
    IBOutlet UICollectionView *photoCollectionView;
}

@property (strong, nonatomic) PhotoSet *photoSet;
@property (strong, nonatomic) OFFlickrAPIRequest *flickrRequest;
@property (strong, nonatomic) NSMutableArray *photoList;

@property (strong, nonatomic) IBOutlet UICollectionView *photoCollectionView;

@end
