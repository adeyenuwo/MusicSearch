//
//  MusicTableViewCell.h
//  MusicSearch
//
//  Created by Paul Ade on 2016-01-22.
//  Copyright © 2016 paulade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
