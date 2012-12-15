//
//  PhotoSetsTableViewController.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 12. 8..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "PhotoSetsTableViewController.h"
#import "AppDelegate.h"
#import "PhotoSet.h"
#import "GroupPhotoViewController.h"

@interface PhotoSetsTableViewController ()

@end

@implementation PhotoSetsTableViewController

@synthesize flickrRequest, photoSetTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSArray *objects = [self fetch:nil];
    if( [objects count] == 0 ){
        [self.flickrRequest setDelegate:self];
        [self.flickrRequest callAPIMethodWithGET:@"flickr.photosets.getList" arguments:[NSDictionary dictionaryWithObjectsAndKeys: nil]];
    } else {
        [self fetchAllPhotoSet:objects];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)saveSlideMode
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Slide" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    
    
        NSManagedObject *row = nil;
        row = [NSEntityDescription insertNewObjectForEntityForName:@"Slide" inManagedObjectContext:context];
        //[row setValue:photoSet.canComment forKey:@"can_comment"];

    [context save:&error];
}

- (void)saveModel
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    
    for( PhotoSet *photoSet in photoSetList){
        NSManagedObject *row = nil;
        row = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoSets" inManagedObjectContext:context];
        [row setValue:photoSet.canComment forKey:@"can_comment"];
        [row setValue:photoSet.countComments forKey:@"count_comments"];
        [row setValue:photoSet.countViews forKey:@"count_views"];
        [row setValue:photoSet.dateCreate forKey:@"date_create"];
        [row setValue:photoSet.dateUpdate forKey:@"date_update"];
        [row setValue:photoSet.descriptions forKey:@"descriptions"];
        [row setValue:photoSet.farm forKey:@"farm"];
        [row setValue:photoSet.fid forKey:@"fid"];
        [row setValue:photoSet.needsInterstitial forKey:@"needs_interstitial"];
        [row setValue:photoSet.photos forKey:@"photos"];
        [row setValue:photoSet.primary forKey:@"primary"];
        [row setValue:photoSet.secret forKey:@"secret"];
        [row setValue:photoSet.server forKey:@"server"];
        [row setValue:photoSet.title forKey:@"title"];
        [row setValue:photoSet.videos forKey:@"videos"];
        [row setValue:photoSet.visibilityCanSeeSet forKey:@"visibility_can_see_set"];
    }
    [context save:&error];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [photoSetList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    PhotoSet *photoSet = [photoSetList objectAtIndex:indexPath.row];
    if( photoSet.thumbnail ){
        cell.imageView.image = photoSet.thumbnail;
        cell.textLabel.text = photoSet.title;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
        cell.textLabel.text = photoSet.title;
        
        GGImageLoader * imageLoader = [[GGImageLoader alloc] initWithURL:[NSURL URLWithString:[photoSet getUrl:@"s"]]];
        [imageLoader setDelegate:self];
        [imageLoader setIndexPathInTableView:indexPath];
        [imageLoader load];
    }
    
    return cell;
}

- (void)moveToGroupPhotoList
{
    [self performSegueWithIdentifier:@"photoListSegue" sender:nil];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    PhotoSet *photoSet = [photoSetList objectAtIndex:indexPath.row];
    photoSet.isSelected = !photoSet.isSelected;
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoSet *photoSet = [photoSetList objectAtIndex:indexPath.row];
    if( photoSet.isSelected == YES )
    {
        [cell setBackgroundColor:[UIColor redColor]];
    } else {
        [cell setBackgroundColor:[UIColor magentaColor]];
    }

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

#pragma mark - Flickr delegate
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary
{
    photoSetList = [[NSMutableArray alloc] init];
    
    NSArray *photoset = [inResponseDictionary valueForKeyPath:@"photosets.photoset"];
    [self setModel:photoset];
    [self saveModel];
}

- (void)setModel:(NSArray *)data
{
    NSEnumerator *enumerator = [data reverseObjectEnumerator];
    
    for(NSDictionary *aKey in enumerator){
        PhotoSet *photoSet = [[PhotoSet alloc] initWithData:aKey];
        [photoSetList addObject:photoSet];
    }
    
    [photoSetTableView reloadData];
}

- (NSArray *)fetch:(NSPredicate *)predicate
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date_create" ascending:NO];
    return [self fetchEntity:@"PhotoSets" withPredicate:predicate withSortDescriptor:sortDescriptor];
}

- (NSArray *)fetchEntity:(NSString *)enityName withPredicate:(NSPredicate *)predicate withSortDescriptor:(NSSortDescriptor *) sortDescriptor
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:enityName inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSError *error;
    
    [request setEntity:entityDescription];
    
    if( predicate ){
        [request setPredicate:predicate];
    }
    
    if( sortDescriptor){
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptors];
    }
    
    NSArray *results = [[appDelegate managedObjectContext] executeFetchRequest:request error:&error];
    return results;
}

- (void)fetchAllPhotoSet:(NSArray *)objects
{
    
    photoSetList = [[NSMutableArray alloc] init];
    for( NSManagedObject *oneObject in objects ){
        PhotoSet *photoSet = [[PhotoSet alloc] init];
        photoSet.canComment = [oneObject valueForKey:@"can_comment"];
        photoSet.countComments = [oneObject valueForKey:@"count_comments"];
        photoSet.countViews = [oneObject valueForKey:@"count_views"];
        photoSet.dateCreate = [oneObject valueForKey:@"date_create"];
        photoSet.dateUpdate = [oneObject valueForKey:@"date_update"];
        photoSet.descriptions = [oneObject valueForKey:@"descriptions"];
        photoSet.farm = [oneObject valueForKey:@"farm"];
        photoSet.fid = [oneObject valueForKey:@"fid"];
        photoSet.needsInterstitial = [oneObject valueForKey:@"needs_interstitial"];
        photoSet.photos = [oneObject valueForKey:@"photos"];
        photoSet.primary = [oneObject valueForKey:@"primary"];
        photoSet.secret = [oneObject valueForKey:@"secret"];
        photoSet.server = [oneObject valueForKey:@"server"];
        photoSet.title = [oneObject valueForKey:@"title"];
        photoSet.videos = [oneObject valueForKey:@"videos"];
        photoSet.visibilityCanSeeSet = [oneObject valueForKey:@"visibility_can_see_set"];
        
        [photoSetList addObject:photoSet];
    }
}

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError
{
    NSLog(@"에러네!" );
}


#pragma mark - image loader
- (void)imageLoader:(GGImageLoader *)loader
	   didLoadImage:(UIImage *)anImage forTableIndexPath:(NSIndexPath *)indexPath
{
    PhotoSet *photoSet = [photoSetList objectAtIndex:indexPath.row];
    photoSet.thumbnail = anImage;
    [photoSet saveToFile];
    
    UITableViewCell *cell = (UITableViewCell *)[photoSetTableView cellForRowAtIndexPath:indexPath];
    cell.imageView.image = anImage;
    cell.textLabel.text = photoSet.title;
    
    //[photoSetTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark Deferred image loading (UIScrollViewDelegate)
- (void)loadImagesForOnscreenRows
{
    NSArray *visiblePaths = [photoSetTableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in visiblePaths)
    {
        PhotoSet *photoSet = [photoSetList objectAtIndex:indexPath.row];
        if (!photoSet.thumbnail) // avoid the app icon download if the app already has an icon
        {
            GGImageLoader * imageLoader = [[GGImageLoader alloc] initWithURL:[NSURL URLWithString:[photoSet getUrl:@"s"]]];
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

#pragma mark - segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GroupPhotoViewController *viewController = (GroupPhotoViewController *)segue.destinationViewController;
    viewController.photoSet = [photoSetList objectAtIndex:photoSetTableView.indexPathForSelectedRow.row];
}


@end


