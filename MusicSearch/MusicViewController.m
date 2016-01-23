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

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = [[self musicEntity] count];
    return rows;
}

- (MusicTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MusicCell";
    MusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [self configureCell:cell forTableView:tableView atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(MusicTableViewCell *)cell forTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    Music *music = [_musicEntity objectAtIndex:indexPath.row];
    cell.albumNameLabel.text = [music albumName];
    cell.artistNameLabel.text = [music artistName];
    cell.trackNameLabel.text = [music trackName];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://is1.mzstatic.com/image/thumb/Music/v4/77/75/9d/77759d17-3f8f-1c81-8e4d-fa8cb2c17f61/source/60x60bb.jpg"]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [cell.albumImageView setImageWithURLRequest:request
                               placeholderImage:[UIImage imageNamed:@"sample-128.png"]
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                            cell.albumImageView.image = image;
                                            [UIView animateWithDuration:0.5
                                                             animations:^{
                                                                 cell.albumImageView.alpha = 1.0;
                                                             }];
                                            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                            [cell.activityIndicator stopAnimating];
                                            
                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                            NSLog(@"An error occured retrieving the image %@", [error description]);
                                        }];

//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[music albumImage]]];
//    [cell.albumImageView setImageWithURL:[NSURL URLWithString:[music albumImage]]];
    NSLog(@"Image URL %@", [music albumImage]);
//    [cell.albumImageView setImageWithURLRequest:urlRequest placeholderImage:nil success:nil failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        //
//    }];
    
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[music albumImage]]];
//    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
//    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
//    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Response: %@", responseObject);
//        cell.albumImageView.image = responseObject;
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Image error: %@", error);
//    }];
//    [requestOperation start];
}

#pragma mark - UISearchBar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search button was clicked now!. Search Term is %@", searchBar.text);
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:searchBar.text, @"searchterm", nil];
    [[APIClient sharedInstance] getCommand:params onCompletion:^(NSDictionary *json) {
        if ([json objectForKey:@"results" ] != nil) {
            _dictionary = [json objectForKey:@"results"];
            Music *music = [[Music alloc] init];
            for (id obj in _dictionary) {
                music.albumName = [obj valueForKey:@"collectionName"];
                music.artistName = [obj valueForKey:@"artistName"];
                music.trackName = [obj valueForKey:@"trackName"];
                music.albumImage = [obj valueForKey:@"artworkUrl60"];
                [_musicEntity addObject:music];
            }
            //            _music = [_dictionary valueForKeyPath:@"results"];
            
            //            for (id obj in _musicEntity) {
            //                Music *music1 = [[Music alloc] init];
            //                music1.albumName = [obj valueForKey:@"artistName"];
            //                NSLog(@"Name %@", music1.albumName);
            //                //                music.artistName = [obj valueForKey:@"artistName"];
            //                //                music.trackName = [obj valueForKey:@"trackName"];
            //                //                music.albumImage = [obj valueForKey:@"artworkUrl60"];
            //                //                [_musicEntity addObject:music];
            //            }
            
            // Update the UI after the model is changed by data fetched from the API
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
    }];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"Search text did begin editing!");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
