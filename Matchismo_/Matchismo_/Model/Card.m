//
//  Card.m
//  Matchismo_
//
//  Created by Bence Berenyi on 06/03/14.
//  Copyright (c) 2014 Bence Berenyi. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
