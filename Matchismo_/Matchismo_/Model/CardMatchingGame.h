//
//  CardMatchingGame.h
//  Matchismo_
//
//  Created by Bence Berenyi on 07/03/14.
//  Copyright (c) 2014 Bence Berenyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated init.
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)choosenCardAtIndex:(NSUInteger)index;
- (Card *)cardtAtIndex:(NSUInteger)index;


@property (nonatomic, readonly) NSInteger score;//pont
@property (nonatomic, readwrite) NSInteger mode; //jatekmod

@end
