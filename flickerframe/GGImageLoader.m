//
//  GGImageLoader.m
//  PhotoStory
//
//  Created by jinwoo choi on 12. 3. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "GGImageLoader.h"

@implementation GGImageLoader

@synthesize image;
@synthesize indexPathInTableView;

- (id)initWithURL:(NSURL *)aURL
{
	url = aURL;
	return self;
}

- (void)setDelegate:(id)anObject
{
	delegate = anObject;
}

- (void)load
{
	// SHOW NETWORK INDICATOR
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	// SET UP THE REQUEST
	NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    
	// SET UP THE CONNECTION
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
	// NEW MUT DATA
	mutData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
	if( [delegate respondsToSelector:@selector(imageLoader:didReceieveError:)] )
	{
		[delegate imageLoader:self
			  didReceiveError:error];
	}
}

- (void)connection:(NSURLConnection *)connection
	didReceiveData:(NSData *)data
{
	// APPEND THE DATA
	[mutData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{
	// ONCE LOADED HIDE NETWORK INDICATOR
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	// CREATE NEW UIIMAGE FROM THE DATA
	image = [[UIImage alloc] initWithData:mutData];
	if( [delegate respondsToSelector:@selector(imageLoader:didLoadImage:forTableIndexPath:)] )
	{
        [delegate imageLoader:self didLoadImage:image forTableIndexPath:indexPathInTableView];
	}
    
}

@end