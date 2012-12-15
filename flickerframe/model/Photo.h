//
//  Photo.h
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 9..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoSet.h"

@interface Photo : NSObject {
    NSNumber *farm;
    NSString *fid;
    NSNumber *isprimary;
    NSString *secret;
    NSNumber *server;
    NSString *title;
    NSString *pid;
    
    UIImage *thumbnail;
    
    PhotoSet *photoSet;
}

@property (strong, nonatomic) UIImage *thumbnail;
@property (readonly, nonatomic) NSString *fid;

- (id)initWithData:(NSDictionary *)data;
- (id)initWithData:(PhotoSet *)parentPhotoSet photoData:(NSDictionary *)data;

- (NSString *)getUrl;
- (NSString *)getUrl:(NSString *)type;
- (void)saveToFile;
- (void)loadFromFile;
@end
