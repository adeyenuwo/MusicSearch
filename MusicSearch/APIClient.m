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
#define kAPIHostWiki @"http://lyrics.wikia.com"
#define kAPIPathWiki @"api.php?func="

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
        //Initialize the object in details as required
        searchOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kAPIHostApple]];
        wikiOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kAPIHostWiki]];

        //
        searchOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        searchOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        wikiOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
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



- (BOOL)isAuthorized
{
    return YES;
}

- (void)getCommand:(NSDictionary *)params onCompletion:(JSONResponseBlock)completionBlock
{
    NSString* encodedUrl = [[params objectForKey:@"searchterm"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] ;
    
    NSLog(@"Full URL now %@", [kAPIPathApple stringByAppendingString:encodedUrl]);
    [searchOperationManager GET:[kAPIPathApple stringByAppendingString:encodedUrl] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Success
        NSLog(@"Data returned %@", [responseObject description]);
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Failure
        NSLog(@"An error has occurred!");
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
    }];
}

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
