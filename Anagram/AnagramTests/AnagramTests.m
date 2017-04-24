//
//  AnagramTests.m
//  AnagramTests
//
//  Created by Fahied on 23/04/2017.
//  Copyright © 2017 OLX PK. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AnagramDetector.h"
@interface AnagramTests : XCTestCase
@property (nonatomic, strong) AnagramDetector *anagramDetector;
@end

@implementation AnagramTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.anagramDetector = [AnagramDetector new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNoMatches {
    NSArray *words = @[@"diaper",@"hello",@"world",@"zombies",@"pants"];
    NSSet *resultSet = [NSSet setWithArray:[self.anagramDetector detectAnagramsFromWords:words]];
    NSSet *expected = [NSSet setWithArray:words];
    
    XCTAssert([resultSet isEqualToSet:expected]);
}

- (void)testDetectSimpleAnagram {
    NSArray *words = @[@"ant",@"tan",@"stand",@"at"];
    NSSet *resultSet = [NSSet setWithArray:[self.anagramDetector detectAnagramsFromWords:words]];
    NSSet *expected = [NSSet setWithObjects:@"at",@"ant,tan",@"stand", nil];
    XCTAssert([resultSet isEqualToSet:expected]);
}

- (void)testDetectMultipleAnagrams {
    NSArray *words = @[@"stream",@"pigeon",@"maters",@"master"];
    NSSet *resultSet = [NSSet setWithArray:[self.anagramDetector detectAnagramsFromWords:words]];
    NSSet *expected = [NSSet setWithObjects:@"stream,maters,master",@"pigeon", nil];
    XCTAssert([resultSet isEqualToSet:expected]);
}

- (void)testDoesNotConfuseDifferentDuplicates {
    
    NSArray *words = @[@"galea",@"eagle"];
    NSSet *resultSet = [NSSet setWithArray:[self.anagramDetector detectAnagramsFromWords:words]];
    NSSet *expected = [NSSet setWithArray:words];
    XCTAssert([resultSet isEqualToSet:expected]);
}

- (void)testIdenticalWordIsNotAnagram {
    
    NSArray *words = @[@"corn", @"dark", @"Corn", @"rank", @"CORN", @"cron", @"park"];
    NSSet *resultSet = [NSSet setWithArray:[self.anagramDetector detectAnagramsFromWords:words]];
    NSSet *expected = [NSSet setWithArray:@[@"corn,cron", @"dark", @"Corn", @"rank", @"CORN", @"park"]];
    XCTAssert([resultSet isEqualToSet:expected]);
}

- (void)testEliminateAnagramsWithSameChecksum {
    NSArray *words = @[@"corn", @"dark"];
    NSSet *resultSet = [NSSet setWithArray:[self.anagramDetector detectAnagramsFromWords:words]];
    NSSet *expected = [NSSet setWithArray:@[@"corn", @"dark"]];
    XCTAssert([resultSet isEqualToSet:expected]);
}

- (void)testEliminateAnagramSubsets {
    NSArray *words = @[@"good", @"dog",@"goody"];
    NSSet *resultSet = [NSSet setWithArray:[self.anagramDetector detectAnagramsFromWords:words]];
    NSSet *expected = [NSSet setWithArray:@[@"good", @"dog",@"goody"]];
    XCTAssert([resultSet isEqualToSet:expected]);
}

- (void)testAnagramsAreCaseInsensitive {
    
    NSArray *words = @[@"Orchestra",@"cashregister",@"Carthorse",@"radishes"];
    NSSet *resultSet = [NSSet setWithArray:[self.anagramDetector detectAnagramsFromWords:words]];
    NSSet *expected = [NSSet setWithArray:@[@"Orchestra",@"cashregister",@"Carthorse",@"radishes"]];
    XCTAssert([resultSet isEqualToSet:expected]);
}

@end
