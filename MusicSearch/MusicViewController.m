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
    
    // In order to be able to reach global audiences with the app, internalization is important. This is demonstrated in the next line, pulling the title from the Localizable strings file. In a full-fledged app, all string will be placed in this file and fetched when required. It also makes it easier to have all text in the same place, making it easier to apply copy-updates app-wide, by making changes in the localizable strings file
    self.navigationItem.title = NSLocalizedString(@"MUSIC_SCENE_TITLE", nil);
    _resultArray = [[NSMutableArray alloc] init];
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
    return [_resultArray count];
}

#pragma mark - UITableView Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MusicCell";
    MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // This method helps to separate the customization of the contents of the cell from the delegate method that dequeues a re-usable cell or creates a new one, if there is none to deque.
    [self configureCell:cell forTableView:tableView atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(MusicTableViewCell *)cell forTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    
    Music *music = [_resultArray objectAtIndex:indexPath.row];
    cell.albumNameLabel.text = [music valueForKey:@"collectionName"];
    cell.artistNameLabel.text = [music valueForKey:@"artistName"];
    cell.trackNameLabel.text = [music valueForKey:@"trackName"];
    NSString *urlString = [music valueForKey:@"artworkUrl60"];
    
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
                                            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                        }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyBoard = self.storyboard;
    LyricsViewController *lyricsViewController = [storyBoard instantiateViewControllerWithIdentifier:@"LyricsViewController"];
    Song *aSong = [[Song alloc] init];
    Music *music = [_resultArray objectAtIndex:indexPath.row];
    aSong.artist = [music valueForKey:@"artistName"];
    aSong.song = [music valueForKey:@"trackName"];
    aSong.lyrics = [music valueForKey:@"collectionName"];
    aSong.url = [music valueForKey:@"artworkUrl60"];
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
            _resultArray = [json objectForKey:@"results"];
            
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
