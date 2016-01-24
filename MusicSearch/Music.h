//
//  Music.h
//  YodaSpeak
//
//  Created by Paul Adeyenuwo on 2016-01-22.
//  Copyright © 2016 paulade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject

@property (nonatomic, copy) NSString *trackName;
@property (nonatomic, copy) NSString *artistName;
@property (nonatomic, copy) NSString *albumName;
@property (nonatomic, copy) NSString *albumImageUrl;

/**
 *  This is the Music class
 *
 *  @param dictionary Dictionary of parameters
 *
 *  @return instancetype Music Dictionary
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
