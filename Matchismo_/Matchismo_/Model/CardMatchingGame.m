//
//  CardMatchingGame.m
//  Matchismo_
//
//  Created by Bence Berenyi on 07/03/14.
//  Copyright (c) 2014 Bence Berenyi. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards   //lazy instantiation
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init]; // super's designated init.
    if (self) {
        
        self.mode = 2;

        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        
    }
    return self;
}

- (Card *)cardtAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)choosenCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardtAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"lastEvent" object:[NSString stringWithFormat:@""]];
        } else {
            if(self.mode == 2){
                [self twoCardGame:card];
            }else{
                [self threeCardGame:card];
            }
            /*match against other chosen cards
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                        
                    } else {
                        
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                        
                    }
                    break;//can only choose 2 cards for now
                }
            }
            self.score -= COST_TO_CHOOSE;*/
            
                card.chosen = YES;}
        }
}

- (void)twoCardGame:(Card *)card
{
    //match against other chosen cards
    
    for (Card *otherCard in self.cards) {
        if ((otherCard != card) && otherCard.isChosen && !otherCard.isMatched) {
            
            int matchScore = [card match:@[otherCard]];
            
            if (matchScore) {
                
                self.score += matchScore * MATCH_BONUS;
                otherCard.matched = YES;
                card.matched = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"lastEvent" object:[NSString stringWithFormat:@"Match: %@ %@ for %i points",otherCard.contents, card.contents,matchScore]];
                
            } else {
                
                self.score -= MISMATCH_PENALTY;
                otherCard.chosen = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"lastEvent" object:[NSString stringWithFormat:@"%@ %@ don't match!  %i point penalty!",otherCard.contents, card.contents,MISMATCH_PENALTY]];
                
            }
            break;//can only choose 2 cards for now
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"lastEvent" object:[NSString stringWithFormat:@"%@",card.contents]];
    }
    self.score -= COST_TO_CHOOSE;
    
}

- (void)threeCardGame:(Card *)card
{
    //match against other chosen cards
    for (Card *otherCard in self.cards) {
        for (Card *thirdCard in self.cards){
            
            if ((otherCard != card) && (thirdCard != card) && (otherCard != thirdCard))
            {
                if((otherCard.isChosen) && (!otherCard.isMatched) && (thirdCard.isChosen) && (!thirdCard.isMatched)){
                    
                    int matchScore = [card match:@[otherCard, thirdCard]];
                    
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        thirdCard.matched = YES;
                        card.matched = YES;
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"lastEvent" object:[NSString stringWithFormat:@"Match: %@ %@ %@ for %i points",otherCard.contents, card.contents, thirdCard.contents, matchScore]];
                    }else{
                        self.score -= MISMATCH_PENALTY;
                        //otherCard.flip = YES;
                        //thirdCard.flip = YES;
                        //card.flip = YES;
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"lastEvent" object:[NSString stringWithFormat:@"%@ %@ %@ don't match!  %i point penalty!",otherCard.contents, card.contents, thirdCard.contents, MISMATCH_PENALTY]];
                    }
                    
                }
                
                break;//3 card
            }
        }

        
    }
    self.score -= COST_TO_CHOOSE;
}


@end


