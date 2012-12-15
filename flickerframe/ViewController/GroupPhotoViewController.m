//
//  GroupPhotoViewController.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 7..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "GroupPhotoViewController.h"
#import "AppDelegate.h"
#import "Photo.h"
#import "ThumbCell.h"

@interface GroupPhotoViewController ()

@end

@implementation GroupPhotoViewController

@synthesize photoSet, flickrRequest;
@synthesize photoList;
@synthesize photoCollectionView;

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
	// Do any additional setup after loading the view.
//    NSLog(@"%@", photoSet );
    
    [self.flickrRequest setDelegate:self];
    [self.flickrRequest callAPIMethodWithGET:@"flickr.photosets.getPhotos" arguments:[NSDictionary dictionaryWithObjectsAndKeys: photoSet.fid, @"photoset_id", nil]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSLog(@"%@", [photoList count]);
    return [photoList count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    ThumbCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier1 forIndexPath:indexPath];
    
    Photo *photo = [photoList objectAtIndex:indexPath.row];
    if( !photo.thumbnail ){
        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        
        GGImageLoader * imageLoader = [[GGImageLoader alloc] initWithURL:[NSURL URLWithString:[photo getUrl:@"s"]]];
        [imageLoader setDelegate:self];
        [imageLoader setIndexPathInTableView:indexPath];
        [imageLoader load];
        
    } else {
        cell.imageView.image = photo.thumbnail;
    }
    
    return cell;
}

#pragma mark - Flickr request

- (OFFlickrAPIRequest *)flickrRequest
{
    if (!flickrRequest) {
        flickrRequest = [[OFFlickrAPIRequest alloc] initWithAPIContext:[AppDelegate sharedDelegate].flickrContext];
        [flickrRequest setDelegate:self];
        [flickrRequest setRequestTimeoutInterval:60.0];
    }
    
    return flickrRequest;
}

#pragma mark - Flickr

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
    //NSLog(@"%@", inResponseDictionary );
    
    photoList = [[NSMutableArray alloc] init];
    
    NSEnumerator *enumerator = [[inResponseDictionary valueForKeyPath:@"photoset.photo"] reverseObjectEnumerator];
    
    for(NSDictionary *aKey in enumerator){
        Photo *photo = [[Photo alloc] initWithData:photoSet photoData:aKey];
        [photoList addObject:photo];
    }
    
    [photoCollectionView reloadData];
    //[self loadImagesForOnscreenRows];
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError
{
    NSLog(@"에러네!");
}


#pragma mark - image loader
- (void)imageLoader:(GGImageLoader *)loader
	   didLoadImage:(UIImage *)anImage forTableIndexPath:(NSIndexPath *)indexPath
{
    Photo *photo = [photoList objectAtIndex:indexPath.row];
    photo.thumbnail = anImage;
    
    ThumbCell *cell = (ThumbCell *)[photoCollectionView cellForItemAtIndexPath:indexPath];
    cell.imageView.image = anImage;
    
//    [photoCollectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}

#pragma mark Deferred image loading (UIScrollViewDelegate)
- (void)loadImagesForOnscreenRows
{
    NSArray *visiblePaths = [photoCollectionView indexPathsForVisibleItems];
    for (NSIndexPath *indexPath in visiblePaths)
    {
        Photo *photo = [photoList objectAtIndex:indexPath.row];
        if (!photo.thumbnail) // avoid the app icon download if the app already has an icon
        {
            GGImageLoader * imageLoader = [[GGImageLoader alloc] initWithURL:[NSURL URLWithString:[photo getUrl:@"s"]]];
            [imageLoader setDelegate:self];
            [imageLoader setIndexPathInTableView:indexPath];
            [imageLoader load];
        }
    }
}

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


@end
