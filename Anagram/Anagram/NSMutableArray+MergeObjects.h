//
//  NSMutableArray+MergeObjects.h
//  Anagram
//
//  Created by Fahied on 24/04/2017.
//  Copyright © 2017 OLX PK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (MergeObjects)

-(void) mergeObjectsAtIndexes:(NSIndexSet*)indexes toIndex:(NSUInteger)index;

@end
