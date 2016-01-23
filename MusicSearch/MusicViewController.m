//
//  MusicViewController.m
//  MusicSearch
//
//  Created by Paul Adeyenuwo on 2016-01-22.
//  Copyright © 2016 paulade. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _musicEntity = [[NSMutableArray alloc] init];
    _tableView.delegate = self;
    
}

- (void)viewdidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = [[self musicEntity] count];
    return rows;
}

#pragma mark - UITableView Delegate Methods

- (MusicTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MusicCell";
    MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // This method helps to separate the customization of the contents of the cell from the delegate method that dequeues a re-usable cell or creates a new one, if there is none to deque. 
    [self configureCell:cell forTableView:tableView atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(MusicTableViewCell *)cell forTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    Music *music = [_musicEntity objectAtIndex:indexPath.row];
    cell.albumNameLabel.text = [music albumName];
    cell.artistNameLabel.text = [music artistName];
    cell.trackNameLabel.text = [music trackName];
    NSString *urlString = [music albumImageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [cell.albumImageView setImageWithURLRequest:request
                               placeholderImage:[UIImage imageNamed:@"albumart.png"]
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                            cell.albumImageView.image = image;
                                            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                            [cell.activityIndicator stopAnimating];
                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                            NSLog(@"An error occured retrieving the image %@", [error description]);
                                        }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyBoard = self.storyboard;
    LyricsViewController *lyricsViewController = [storyBoard instantiateViewControllerWithIdentifier:@"LyricsViewController"];
    Song *aSong = [[Song alloc] init];
    Music *music = [_musicEntity objectAtIndex:indexPath.row];
    aSong.artist = [music valueForKey:@"artistName"];
    aSong.song = [music valueForKey:@"trackName"];
    aSong.lyrics = [music valueForKey:@"albumName"];
    aSong.url = [music valueForKey:@"albumImageUrl"];
    lyricsViewController.song = aSong;
    [self.navigationController pushViewController:lyricsViewController animated:YES];
}

#pragma mark - UISearchBar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    // Dismiss the keyboard
    [searchBar resignFirstResponder];
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:searchBar.text, @"searchterm", nil];
    [[APIClient sharedInstance] getMusicCommand:params onCompletion:^(NSDictionary *json) {
        if ([json objectForKey:@"results" ] != nil) {
            _dictionary = [json objectForKey:@"results"];
            Music *music = [[Music alloc] init];
            for (id obj in _dictionary) {
                music.albumName = [obj valueForKey:@"collectionName"];
                music.artistName = [obj valueForKey:@"artistName"];
                music.trackName = [obj valueForKey:@"trackName"];
                music.albumImageUrl = [obj valueForKey:@"artworkUrl60"];
                [_musicEntity addObject:music];
            }
            
            // Update the UI after the model is changed by data fetched from the API
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
    }];
}

// This method has been added here to demonstrate how different events from the SearchBar can be handled. Here, I can do something if the user starts to edit the search field
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //NSLog(@"Search text did begin editing!");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
