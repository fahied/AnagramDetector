//
//  NSArray+Utilities.m
//  Anagram
//
//  Created by Fahied on 24/04/2017.
//  Copyright © 2017 OLX PK. All rights reserved.
//

#import "NSArray+Utilities.h"

@implementation NSArray (Utilities)


- (NSArray*)sortByStringLength {
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"length" ascending:YES selector:nil];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedWords = [self sortedArrayUsingDescriptors:sortDescriptors];
    return sortedWords;
}


- (NSString*)prettyPrint {
    
    NSString *values = [self componentsJoinedByString:@"\n"];
    return values;
}

-(NSArray*)flatNestedArrays{
    
    return [self valueForKeyPath: @"@unionOfArrays.self"];
}

@end
