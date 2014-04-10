//
//  Deck.h
//  Matchismo_
//
//  Created by Bence Berenyi on 06/03/14.
//  Copyright (c) 2014 Bence Berenyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
