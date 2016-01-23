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
typedef void (^DataResponseBlock)(NSData *data);


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
- (void)getMusicCommand:(NSDictionary *)params onCompletion:(JSONResponseBlock)completionBlock;

/**
 *  <#Description#>
 *
 *  @param params          <#params description#>
 *  @param completionBlock <#completionBlock description#>
 */
- (void)getLyricsCommand:(NSDictionary *)params onCompletion:(DataResponseBlock)completionBlock;

/**
 *  This method is used to monitor connectivity to the API Endpoint.
 */
- (void)startMonitoringNetworkReachability;
@end
