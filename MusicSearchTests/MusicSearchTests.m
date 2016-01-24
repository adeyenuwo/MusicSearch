//
//  MusicSearchTests.m
//  MusicSearchTests
//
//  Created by Paul Adeyenuwo on 2016-01-22.
//  Copyright © 2016 paulade. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Music.h"
#import "Song.h"
#import "MusicViewController.h"
#import "LyricsViewController.h"

@interface MusicSearchTests : XCTestCase

@property (nonatomic) MusicViewController *musicVcToTest;
@property (nonatomic) LyricsViewController *LyricsVcToTest;
@property (nonatomic) Music *musicToTest;
@property (nonatomic) Song *songToTest;

@end

@implementation MusicSearchTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

/* Errors occurred AFHTTPRequestOperationManager not found while creating tests I will have to leave this as I am almost out of time!
  http://stackoverflow.com/questions/25216925/afnetworking-h-file-not-found-when-building-for-tests

- (void)testMusic {
    NSDictionary *testDictionary = [NSDictionary dictionaryWithObjectsAndKeys: @"Tom Waits", @"artistName", @"Mule Variations", @"albumName", @"Hold On", @"trackName", @"url", @"http://is5.mzstatic.com/image/thumb/Music/v4/0d/40/8a/0d408a3c-e8aa-ba01-b928-d3b76d28891d/source/60x60bb.jpg", @"image", nil];
    Music *music = [self.musicToTest initWithDictionary:testDictionary];
    XCTAssertNotNil(music);
    
}

- (void)testSong {
    NSDictionary *testDictionary = [NSDictionary dictionaryWithObjectsAndKeys: @"Tom Waits", @"artist", @"Hold On", @"song", @"Mule Variations", @"lyrics", @"http://is5.mzstatic.com/image/thumb/Music/v4/0d/40/8a/0d408a3c-e8aa-ba01-b928-d3b76d28891d/source/60x60bb.jpg", @"url", nil];
    Song *song = [self.songToTest initWithDictionary:testDictionary];
    XCTAssertNotNil(song);
    
}
 
  */



@end
