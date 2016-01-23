//
//  LyricsViewController.h
//  MusicSearch
//
//  Created by Paul Ade on 2016-01-23.
//  Copyright © 2016 paulade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIClient.h"
#import "Song.h"

@interface LyricsViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumImageUrlLabel;
@property (weak, nonatomic) IBOutlet UIWebView *lyricsWebView;
@property (strong, nonatomic) Song *song;

@end
