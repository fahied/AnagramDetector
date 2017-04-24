//
//  AnagramFinder.m
//  Anagram
//
//  Created by Fahied on 23/04/2017.
//  Copyright © 2017 OLX PK. All rights reserved.
//

#import "AnagramDetector.h"
#import "NSMutableArray+MergeObjects.h"
#import "NSString+anagrams.h"
#import "NSArray+Utilities.h"

@implementation AnagramDetector

- (NSArray*)detectAnagramsFromWords:(NSArray*)words {
    
    NSArray *wordsSortedByStringLength = [words sortByStringLength];
    NSArray *groups = [self groupWordsByStringLength:wordsSortedByStringLength];
    NSMutableArray *groupsWithAnagrams = [NSMutableArray new];
    
    /*
     * All words will be segmented into group by the string length
     * It will allow us search for anagrams faster
     * It will allow us later to adapt to reactive programming where signal react
     * after each group has been evaluated
     * The result would be smoother/nonblocking ui
     */
    for (NSMutableArray *group in groups) {
        
        // if a group has no members continue to next group
        if (group.count < 1) {
            continue;
        }
        // if a group has only one member it can not have an anagram
        else if (group.count == 1) {
            [groupsWithAnagrams addObject:group];
            continue;
        }
        // local variable definition
        NSUInteger i = 0;
        
        // loop through all the words and find any matching anagram and merge them with orignal word
        do
        {
            NSString *word = [group objectAtIndex:i];
            NSIndexSet *anagramIndexes = [self indexesOfAnagramOf:word inGroup:group];
            if (anagramIndexes.count >0) {
                [group mergeObjectsAtIndexes:anagramIndexes toIndex:i];
            }
            i++;
        }while( i < group.count );
        [groupsWithAnagrams addObject:group];
    }
    
    return [groupsWithAnagrams flatNestedArrays];
}

-(NSIndexSet*)indexesOfAnagramOf:(NSString*)word inGroup:(NSMutableArray*)group{
    
    NSIndexSet *matching = [group indexesOfObjectsWithOptions:NSEnumerationConcurrent passingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            return NO;
        }
        return [obj anagram:word];
    }];
    return matching;
}


-(NSArray*)groupWordsByStringLength:(NSArray*)words {
    
    NSMutableArray *groups = [NSMutableArray new];
    NSInteger stringLength = [[words firstObject] length];
    NSMutableArray *group = [NSMutableArray new];
    
    for (int i = 0; i< words.count; i++) {
        
        NSString *word = [words objectAtIndex:i];
        
        if (word.length == stringLength) {
            
            [group addObject:word];
        } else {
            [groups addObject:group];
            
            group = [NSMutableArray new];
            stringLength = word.length;
            [group addObject:word];
        }
        
        if (i == words.count-1) {
            [groups addObject:group];
        }
    }
    return groups;
}

@end
