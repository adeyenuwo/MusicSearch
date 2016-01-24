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
 *  Initialize the API Client
 *
 *  @return API Client Instance
 */
- (instancetype) init;

/**
 *  Singleton class instance of API Client
 *
 *  @return sharedInstance
 */
+ (instancetype) sharedInstance;

/**
 *  Convenience wrapper method for POST operations
 *
 *  @param params           dictionary of parameters
 *  @param completionBlock completionBlock
 */
- (void)postCommand:(NSDictionary *)params onCompletion:(JSONResponseBlock)completionBlock;

/**
 *  Convenience wrapper method for GET operations
 *
 *  @param params           dictionary of parameters
 *  @param completionBlock completionBlock
 */
- (void)getMusicCommand:(NSDictionary *)params onCompletion:(JSONResponseBlock)completionBlock;

/**
 *  Convenience wrapper method for GET operations
 *
 *  @param params          dictionary of parameters
 *  @param completionBlock completionBlock
 */
- (void)getLyricsCommand:(NSDictionary *)params onCompletion:(DataResponseBlock)completionBlock;

/**
 *  This method is used to monitor connectivity to the API Endpoint.
 */
- (void)startMonitoringNetworkReachability;
@end
