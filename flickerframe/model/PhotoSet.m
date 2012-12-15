//
//  PhotoSet.m
//  flickerframe
//
//  Created by jinwoo choi on 12. 11. 9..
//  Copyright (c) 2012년 jinwoo choi. All rights reserved.
//

#import "PhotoSet.h"

/*
 <photoset id="72157626216528324" primary="5504567858" secret="017804c585" server="5174" farm="6" photos="22" videos="0" count_views="137" count_comments="0" can_comment="1" date_create="1299514498" date_update="1300335009">
 <title>Avis Blanche</title>
 <description>My Grandma's Recipe File.</description>
 </photoset>
 */


@implementation PhotoSet

@synthesize thumbnail;
@synthesize isSelected;
@synthesize canComment, countComments, countViews, dateCreate, dateUpdate, descriptions, farm, fid, needsInterstitial, photos, primary, secret, server, title, videos, visibilityCanSeeSet;


- (id)initWithData:(NSDictionary *)data
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    canComment = [formatter numberFromString:[data valueForKeyPath:@"can_comment"]];
    countComments = [formatter numberFromString:[data valueForKeyPath:@"count_comments"]];
    countViews = [formatter numberFromString:[data valueForKeyPath:@"count_views"]];
    dateCreate = [formatter numberFromString:[data valueForKeyPath:@"date_create"]];
    dateUpdate = [formatter numberFromString:[data valueForKeyPath:@"date_update"]];
    descriptions = [data valueForKeyPath:@"description._text"];
    farm = [formatter numberFromString:[data valueForKeyPath:@"farm"]];
    fid = [data valueForKeyPath:@"id"];
    needsInterstitial = [formatter numberFromString:[data valueForKeyPath:@"needs_interstitial"]];
    photos = [formatter numberFromString:[data valueForKeyPath:@"photos"]];
    primary = [data valueForKeyPath:@"primary"];
    secret = [data valueForKeyPath:@"secret"];
    server = [formatter numberFromString:[data valueForKeyPath:@"server"]];
    title = [data valueForKeyPath:@"title._text"];
    videos = [formatter numberFromString:[data valueForKeyPath:@"videos"]];
    visibilityCanSeeSet = [formatter numberFromString:[data valueForKeyPath:@"visibility_can_see_set"]];
    
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
    NSString *url = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_%@.jpg", farm, server, primary, secret, type];
    NSLog(@"%@", url);
    return url;
}

- (void)saveToFile
{
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSString *filename = [documentsDirectory stringByAppendingPathComponent:@"file.txt"];
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
