//
//  PhotoSetsTableViewController.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 12. 8..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectiveFlickr.h"
#import "GGImageLoader.h"

@interface PhotoSetsTableViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate, OFFlickrAPIRequestDelegate, GGImageLoaderProtocol, UIScrollViewDelegate> {
    OFFlickrAPIRequest *flickrRequest;
    NSMutableArray *photoSetList;
    IBOutlet UITableView *photoSetTableView;
}

@property (nonatomic, retain) OFFlickrAPIRequest *flickrRequest;
@property (nonatomic, retain) IBOutlet UITableView *photoSetTableView;

- (void)loadImagesForOnscreenRows;
- (void)setModel:(NSArray *)data;
- (void)saveModel;
- (void)moveToGroupPhotoList;
@end
