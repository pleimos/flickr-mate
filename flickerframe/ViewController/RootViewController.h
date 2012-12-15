//
//  RootViewController.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 10. 28..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectiveFlickr.h"

@interface RootViewController : UINavigationController <OFFlickrAPIRequestDelegate> {
    OFFlickrAPIRequest *flickrRequest;
    BOOL isLogged;
}

@property BOOL isLogged;
@property (nonatomic, strong) OFFlickrAPIRequest *flickrRequest;

- (void)moveToLogin;
- (void)moveToMain;
@end
