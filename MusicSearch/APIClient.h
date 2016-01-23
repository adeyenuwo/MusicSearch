//
//  APIClient.h
//  YodaSpeak
//
//  Created by Paul Adeyenuwo on 2016-01-22.
//  Copyright © 2016 paulade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "UIAlertController+Message.h"

typedef void (^JSONResponseBlock)(NSDictionary *json);

@interface APIClient : NSObject
{
    AFHTTPRequestOperationManager *searchOperationManager;
    AFHTTPRequestOperationManager *wikiOperationManager;

}

/**
 *  <#Description#>
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
- (instancetype) init;

/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype) sharedInstance;

/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isAuthorized;

/**
 *  <#Description#>
 *
 *  @param params          <#params description#>
 *  @param completionBlock <#completionBlock description#>
 */
- (void)postCommand:(NSDictionary *)params onCompletion:(JSONResponseBlock)completionBlock;

/**
 *  <#Description#>
 *
 *  @param params          <#params description#>
 *  @param completionBlock <#completionBlock description#>
 */
- (void)getCommand:(NSDictionary *)params onCompletion:(JSONResponseBlock)completionBlock;

@end
