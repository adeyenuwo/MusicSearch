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
@property (nonatomic, weak) NSString *albumImage;

/**
 *  <#Description#>
 *
 *  @param sentence <#sentence description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithDictionary:(NSDictionary *)sentence;

@end
