//
//  Card.h
//  Matchismo_
//
//  Created by Bence Berenyi on 06/03/14.
//  Copyright (c) 2014 Bence Berenyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
