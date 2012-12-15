//
//  PhotoSet.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 9..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoSet : NSObject {
    NSNumber *canComment;
    NSNumber *countComments;
    NSNumber *countViews;
    NSNumber *dateCreate;
    NSNumber *dateUpdate;
    NSString *descriptions;
    NSNumber *farm;
    NSString *fid;
    NSNumber *needsInterstitial;
    NSNumber *photos;
    NSString *primary;
    NSString *secret;
    NSNumber *server;
    NSString *title;
    NSNumber *videos;
    NSNumber *visibilityCanSeeSet;
    
    Boolean isSelected;
    
    UIImage *thumbnail;
}

@property (strong, nonatomic) NSNumber *canComment;
@property (strong, nonatomic) NSNumber *countComments;
@property (strong, nonatomic) NSNumber *countViews;
@property (strong, nonatomic) NSNumber *dateCreate;
@property (strong, nonatomic) NSNumber *dateUpdate;
@property (strong, nonatomic) NSString *descriptions;
@property (strong, nonatomic) NSNumber *farm;
@property (strong, nonatomic) NSString *fid;
@property (strong, nonatomic) NSNumber *needsInterstitial;
@property (strong, nonatomic) NSNumber *photos;
@property (strong, nonatomic) NSString *primary;
@property (strong, nonatomic) NSString *secret;
@property (strong, nonatomic) NSNumber *server;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *videos;
@property (strong, nonatomic) NSNumber *visibilityCanSeeSet;
@property (strong, nonatomic) UIImage *thumbnail;
@property Boolean isSelected;


- (id)initWithData:(NSDictionary *)data;
- (NSString *)getUrl;
- (NSString *)getUrl:(NSString *)type;
- (void)saveToFile;
- (void)loadFromFile;

@end
