//
//  NSString+anagrams.m
//  Anagram
//
//  Created by Fahied on 23/04/2017.
//  Copyright © 2017 OLX PK. All rights reserved.
//

#import "NSString+anagrams.h"

@implementation NSString (anagrams)

-(BOOL)anagram:(NSString*)word
{
    if (self.length != word.length)
        return NO;
 
    if ([self isEqualToString:word]) {
        return NO;
    }
    
    NSCountedSet *aSet = [[NSCountedSet alloc] init];
    NSCountedSet *bSet = [[NSCountedSet alloc] init];
    
    for (int i = 0; i < self.length; i++)
    {
        [aSet addObject:@([self characterAtIndex:i])];
        [bSet addObject:@([word characterAtIndex:i])];
    }
    
    return [aSet isEqual:bSet];
}

@end
