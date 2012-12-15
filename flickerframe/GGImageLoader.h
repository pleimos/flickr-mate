//
//  GGImageLoader.h
//  PhotoStory
//
//  Created by jinwoo choi on 12. 3. 5..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGImageLoader : NSObject {
	NSURLConnection *connection;
	NSURL *url;
	NSMutableData *mutData;
    NSIndexPath *indexPathInTableView;
	UIImage *image;
	id delegate;
}

@property ( nonatomic, retain ) UIImage * image;
@property ( nonatomic, retain ) NSIndexPath *indexPathInTableView;

- (id)initWithURL:(NSURL *)aURL;
- (void)setDelegate:(id)anObject;
- (void)load;

@end

@protocol GGImageLoaderProtocol

@required
- (void)imageLoader:(GGImageLoader *)loader
	   didLoadImage:(UIImage *)anImage forTableIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)imageLoader:(GGImageLoader *)loader
	didReceiveError:(NSError *)anError;

@end
