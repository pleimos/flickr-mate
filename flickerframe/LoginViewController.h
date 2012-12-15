//
//  LoginViewController.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 10. 27..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjectiveFlickr.h"

@interface LoginViewController : UIViewController <UITextInputDelegate, OFFlickrAPIRequestDelegate> {
    
    OFFlickrAPIRequest *flickrRequest;
    
    UIButton *goLogin;
}

@property (nonatomic, strong) IBOutlet UIButton *goLogin;
@property (nonatomic, strong) OFFlickrAPIRequest *flickrRequest;

- (IBAction)authorizeAction;
- (void)moveToMain;

@end
