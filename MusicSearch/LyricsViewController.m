//
//  LyricsViewController.m
//  MusicSearch
//
//  Created by Paul Ade on 2016-01-23.
//  Copyright © 2016 paulade. All rights reserved.
//

#import "LyricsViewController.h"

@interface LyricsViewController ()

@end

@implementation LyricsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // In order to be able to reach global audiences with the app, internalization is important. This is demonstrated in the next line, pulling the title from the Localizable strings file. In a full-fledged app, all string will be placed in this file and fetched when required. It also makes it easier to have all text in the same place, making it easier to apply copy-updates app-wide, by making changes in the localizable strings file
    self.navigationItem.title = NSLocalizedString(@"LYRICS_SCENE_TITLE", nil);
    _trackNameLabel.text = [_song valueForKey:@"song"];
    _artistNameLabel.text = [_song valueForKey:@"artist"];
    _albumNameLabel.text = [_song valueForKey:@"lyrics"];
    _albumImageUrlLabel.text = [_song valueForKey:@"url"];
    _albumImageUrlLabel.numberOfLines = 0;
    [self loadLyrics];
}

- (NSURL *)parseResponseData:(NSData *)data {
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *responseArray = [NSArray new];
    responseArray = [[[[string stringByReplacingOccurrencesOfString:@"{" withString:@""] stringByReplacingOccurrencesOfString:@"}" withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""] componentsSeparatedByString:@","];
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSURL *url = nil;
    NSTextCheckingResult *result = [linkDetector firstMatchInString:[[responseArray lastObject] description]
                                                            options:0
                                                              range:NSMakeRange(0, [[responseArray lastObject] description].length)];
    if (result.resultType == NSTextCheckingTypeLink) {
        url = result.URL;
    }
    return url;
}

- (void)loadLyrics {
    
    NSDictionary *params = @{@"func": @"getSong", @"artist": _artistNameLabel.text, @"song": _trackNameLabel.text, @"fmt": @"json" };
    [[APIClient sharedInstance] getLyricsCommand:params onCompletion:^(NSData *data) {
        NSURL *url = [self parseResponseData:data];
        if (url != nil) {
            [self loadLyricsWebView:url];
        }
    }];
}

- (void)loadLyricsWebView:(NSURL *)url {
    [_lyricsWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
