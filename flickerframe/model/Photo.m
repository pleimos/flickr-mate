//
//  Photo.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 9..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "Photo.h"

@implementation Photo


@synthesize thumbnail;
@synthesize fid;

- (id)initWithData:(PhotoSet *)parentPhotoSet photoData:(NSDictionary *)data
{
    self = [self initWithData:data];
    photoSet = parentPhotoSet;
    return self;
}

- (id)initWithData:(NSDictionary *)data
{
    farm = [data valueForKeyPath:@"farm"];
    fid = [data valueForKeyPath:@"id"];
    isprimary = [data valueForKeyPath:@"isprimary"];
    secret = [data valueForKeyPath:@"secret"];
    server = [data valueForKeyPath:@"server"];
    title = [data valueForKeyPath:@"title"];
    pid = [data valueForKeyPath:@"pid"];
    
    [self loadFromFile];
    
    return self;
}

- (NSString *)getUrl
{
    return [self getUrl:@"c"];
}

- (NSString *)getUrl:(NSString *)type
{
    // http://farm9.staticflickr.com/8421/7755769606_26bdf250cd_c.jpg
    // http://farm8.staticflickr.com/7113/7752919492_c04d701075_s.jpg
    return [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_%@.jpg", farm, server, fid, secret, type];
}


- (void)saveToFile
{
    if( !thumbnail ){
        return;
    }
    
    NSString *tempPath = NSTemporaryDirectory();
    NSString *setsPath = [tempPath stringByAppendingPathComponent:@"thumbnail"];
    NSString *filename = [setsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", fid]];
    
    NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(thumbnail, 1.0f)];
    [data writeToFile:filename atomically:YES];
    //NSLog(@"save %@", filename);
    
}

- (void)loadFromFile
{
    NSString *tempPath = NSTemporaryDirectory();
    NSString *setsPath = [tempPath stringByAppendingPathComponent:@"thumbnail"];
    NSString *filename = [setsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", fid]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filename]) {
        thumbnail = [[UIImage alloc] initWithContentsOfFile:filename];
        //NSLog(@"load %@", filename);
    }
}

@end
