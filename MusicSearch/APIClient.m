//
//  APIClient.m
//  YodaSpeak
//
//  Created by Paul Adeyenuwo on 2016-01-22.
//  Copyright © 2016 paulade. All rights reserved.
//

#import "APIClient.h"

// API Path for the Apple Search API
#define kAPIHostApple @"https://itunes.apple.com"
#define kAPIPathApple @"search?term="

// API Path for the Wiki API
#define kAPIHostWiki @"https://lyrics.wikia.com"
#define kAPIPathWiki @"api.php?"

@implementation APIClient

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static APIClient *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIClient alloc] init];
    });
    return sharedInstance;
}

#pragma mark
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        /* Initialize the operationManager objects:
           1. searchOperationManager: OperationManager configured to point to the public Apple iTunes Search API Endpoint 
           2. wikiOperationManager: OperationManager configured to point to the public wiki API Endpoint
         */
        searchOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kAPIHostApple]];
        wikiOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kAPIHostWiki]];
        
        // Configure both operation managers request and response serializers. The Wiki API does not return a JSON response, so AFHTTPResponseSerializer is used.
        searchOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        searchOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        wikiOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        wikiOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}


- (void)startMonitoringNetworkReachability
{
    [searchOperationManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                //NSLog(@"No internet connection");
                
                [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert actions:[UIAlertAction actionWithTitle: @"Close" style: UIAlertActionStyleDefault handler: nil]];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //NSLog(@"Reachable by WIFI");
                //[UIAlertView showAlert:@"Success" message:@"Connected via Wi-Fi"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //NSLog(@"Reachable by WAN");
                //[UIAlertView showAlert:@"Success" message:@"Connected via 3G WAN"];
                break;
            default:
                //NSLog(@"Network status is unknown");
                [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert actions:[UIAlertAction actionWithTitle: @"Close" style: UIAlertActionStyleDefault handler: nil]];
                break;
        }
    }];
    
    [searchOperationManager.reachabilityManager startMonitoring];
}

// Note: I have specifically named the two GET methods so it is clearer which endpoint it is connecting to. This API clients supports 2 endpoints for both iTunes and Wiki. In apps with a single endpoint, it would be sufficient to just name this getCommand. POST, PUT, etc commands could be postCommand, putCommand, etc.

- (void)getMusicCommand:(NSDictionary *)params onCompletion:(JSONResponseBlock)completionBlock
{
    // Encode the URL before passing it to the operationManager
    NSString* encodedUrl = [[params objectForKey:@"searchterm"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] ;
    [searchOperationManager GET:[kAPIPathApple stringByAppendingString:encodedUrl] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Success
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Failure
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
    }];
}

- (void)getLyricsCommand:(NSDictionary *)params onCompletion:(DataResponseBlock)completionBlock
{
    [wikiOperationManager GET:kAPIPathWiki
                   parameters:params
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          // Success
                          completionBlock(responseObject);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          // Failure
                          NSData *data = [[error localizedDescription] dataUsingEncoding:NSUTF8StringEncoding];
                          completionBlock(data);
                      }];
}

// This method is not used here because a POST method is not supported for the endpoints and the operations required in this assignment. I am adding this to show how this API client could be extended to be able to support all the REST operations e.g. for POST, PUT, DELETE, etc.
- (void)postCommand:(NSDictionary *)params onCompletion:(JSONResponseBlock)completionBlock
{
    [searchOperationManager POST:kAPIPathApple parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Success
        NSLog(@"Data returned %@", [responseObject description]);
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Failure
        NSLog(@"An error has occurred!");
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
    }];
}


@end
