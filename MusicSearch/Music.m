//
//  Music.m
//  YodaSpeak
//
//  Created by Paul Adeyenuwo on 2016-01-22.
//  Copyright © 2016 paulade. All rights reserved.
//

#import "Music.h"

@implementation Music

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _trackName = [dictionary valueForKey:@"trackName"];
        _artistName = [dictionary valueForKey:@"artistName"];
        _albumName = [dictionary valueForKey:@"albumName"];
        _albumImage = [dictionary valueForKey:@"image"];
    }
    return self;
}
@end
