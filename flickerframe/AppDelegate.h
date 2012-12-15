//
//  AppDelegate.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 10. 27..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectiveFlickr.h"

extern NSString *SnapAndRunShouldUpdateAuthInfoNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate, OFFlickrAPIRequestDelegate>
{
    OFFlickrAPIContext *flickrContext;
	OFFlickrAPIRequest *flickrRequest;
	NSString *flickrUserName;
}

+ (AppDelegate *)sharedDelegate;
- (void)setAndStoreFlickrAuthToken:(NSString *)inAuthToken secret:(NSString *)inSecret;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, readonly) OFFlickrAPIContext *flickrContext;
@property (nonatomic, strong) NSString *flickrUserName;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;




@end


extern NSString *SRCallbackURLBaseString;
