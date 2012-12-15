//
//  MainViewController.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 10. 27..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"
#import "MenuViewController.h"
#import "IIViewDeckController.h"

@interface MainViewController : IIViewDeckController

@property (retain, nonatomic) MenuViewController *menuViewController;
@property (retain, nonatomic) ContentViewController *contentViewController;

@end
