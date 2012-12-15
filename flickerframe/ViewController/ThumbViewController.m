//
//  ThumbViewController.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 3..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "ThumbViewController.h"
#import "ThumbCell.h"
#import "PhotoSet.h"

@interface ThumbViewController ()

@end

@implementation ThumbViewController

@synthesize thunbnailView;
@synthesize photoList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.photoList = [[NSMutableArray alloc] init];
    
    for(int i=0; i<70; i++ ){
        PhotoSet *photoSet = [[PhotoSet alloc] init];
        [self.photoList addObject:photoSet];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - image loader
- (void)imageLoader:(GGImageLoader *)loader
	   didLoadImage:(UIImage *)anImage forTableIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%i, %i", indexPath.item, indexPath.row);
    ThumbCell *cell = (ThumbCell *)[self.thunbnailView cellForItemAtIndexPath:indexPath];
    cell.imageView.image = anImage;
    
    /*
     PhotoSet *photoSet = (PhotoSet *)[self.photoList objectAtIndex:indexPath.row];
    if( !photoSet.imageThumbnail){
        [photoSet setImageThumbnail:anImage];
    }
     */
}


#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 70;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    ThumbCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier1 forIndexPath:indexPath];
    
    // Configure the cell...
    if( cell == nil ){
    }
    cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
    /*
    Photo *photo = (Photo *)[self.photoList objectAtIndex:indexPath.row];
    if( photo.imageThumbnail ){
        cell.imageView.image = photo.imageThumbnail;
    } else {
        if (self.thunbnailView.dragging == NO && self.thunbnailView.decelerating == NO){
            NSString *url = photo.url;
            GGImageLoader * imageLoader = [[GGImageLoader alloc] initWithURL:[NSURL URLWithString:url]];
            [imageLoader setDelegate:self];
            [imageLoader setIndexPathInTableView:indexPath];
            [imageLoader load];
        }
    }
     */
    
    
    return cell;
}

#pragma mark Deferred image loading (UIScrollViewDelegate)


// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}


#pragma mark user method

- (void)loadImagesForOnscreenRows
{
    NSArray *visiblePaths = [self.thunbnailView indexPathsForVisibleItems];
    for (NSIndexPath *indexPath in visiblePaths)
    {
        /*
        Photo *photo = (Photo *)[self.photoList objectAtIndex:indexPath.row];
        if( !photo.imageThumbnail ){
            NSString *url = photo.url;
            GGImageLoader * imageLoader = [[GGImageLoader alloc] initWithURL:[NSURL URLWithString:url]];
            [imageLoader setDelegate:self];
            [imageLoader setIndexPathInTableView:indexPath];
            [imageLoader load];
        }
         */
    }
}



@end
