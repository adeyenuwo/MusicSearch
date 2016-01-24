//
//  MusicViewController.h
//  MusicSearch
//
//  Created by Paul Adeyenuwo on 2016-01-22.
//  Copyright © 2016 paulade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicTableViewCell.h"
#import "APIClient.h"
#import "Music.h"
#import "UIImageView+AFNetworking.h"
#import "LyricsViewController.h"

@interface MusicViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) NSMutableArray *resultArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

