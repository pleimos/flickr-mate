//
//  ContentViewController.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 10. 28..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UITabBarController {
    
}
- (void)loadHomeView;
- (void)loadManageView;
- (void)loadConfigView;
- (void)makeTabBarHidden:(BOOL)hide;

@end
