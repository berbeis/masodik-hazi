//
//  PlayingCard.m
//  Matchismo_
//
//  Created by Bence Berenyi on 06/03/14.
//  Copyright (c) 2014 Bence Berenyi. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


static const int MATCH_RANK = 4;
static const int MATCH_SUIT = 1;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = MATCH_RANK;
        }else if ([otherCard.suit isEqualToString:self.suit]) {
            score = MATCH_SUIT;
        }
    }else{
        for (int i=0; i<[otherCards count]; i++) {
            PlayingCard *thirdCard = [otherCards objectAtIndex:i];
            for (int j=i; j<[otherCards count]; j++) {
                PlayingCard *otherCard = [otherCards objectAtIndex:j];
                if(thirdCard != otherCard){
                    if(otherCard.rank == self.rank || otherCard.rank == thirdCard.rank || thirdCard.rank == self.rank){
                        score += MATCH_RANK;
                    } else if([otherCard.suit isEqualToString:self.suit] || [thirdCard.suit isEqualToString:self.suit] || [otherCard.suit isEqualToString:thirdCard.suit]){
                        score += MATCH_SUIT;
                    }
                }
            }
        }
    }
    
    return score;
}


- (NSString *)contents
{
   NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;     // because we provide getter AND setter


+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}
- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count]-1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@end
