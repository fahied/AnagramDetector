//
//  NSMutableArray+MergeObjects.m
//  Anagram
//
//  Created by Fahied on 24/04/2017.
//  Copyright © 2017 OLX PK. All rights reserved.
//

#import "NSMutableArray+MergeObjects.h"

@implementation NSMutableArray (MergeObjects)

-(void) mergeObjectsAtIndexes:(NSIndexSet*)indexes toIndex:(NSUInteger)index
{
    //word used to match anagrams
    NSString *objectAtIndex = [self objectAtIndex:index];
    //matching anagrams
    NSArray *anagrams = [self objectsAtIndexes: indexes];
    NSArray *objectsToMerge = [@[objectAtIndex]arrayByAddingObjectsFromArray:anagrams];
    NSString *anagramString = [objectsToMerge componentsJoinedByString:@","];
    //remove occurance of anagrams
    [self removeObjectsAtIndexes: indexes];
    //remove orignal word
    [self removeObjectAtIndex:index];
    //insert concatenated string of both word and its anagrams
    [self insertObject:anagramString atIndex:index];
}

@end
