//
//  Song.m
//  MusicSearch
//
//  Created by Paul Ade on 2016-01-23.
//  Copyright © 2016 paulade. All rights reserved.
//

#import "Song.h"

@implementation Song

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _artist = [dictionary valueForKey:@"artist"];
        _song = [dictionary valueForKey:@"song"];
        _lyrics = [dictionary valueForKey:@"lyrics"];
        _url = [dictionary valueForKey:@"url"];
    }
    return self;
}

@end
