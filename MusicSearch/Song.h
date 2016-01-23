//
//  Song.h
//  MusicSearch
//
//  Created by Paul Ade on 2016-01-23.
//  Copyright © 2016 paulade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *song;
@property (nonatomic, copy) NSString *lyrics;
@property (nonatomic, weak) NSString *url;

/**
 *  <#Description#>
 *
 *  @param dictionary A Song dictionary
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
