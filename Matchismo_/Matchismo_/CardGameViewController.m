//
//  CardGameViewController.m
//  Matchismo_
//
//  Created by Bence Berenyi on 06/03/14.
//  Copyright (c) 2014 Bence Berenyi. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
//@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
//@property (nonatomic) int flipCount;
//@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoOrTree;
@property (weak, nonatomic) IBOutlet UISwitch *switchGameMode;
@property (weak, nonatomic) IBOutlet UILabel *lastEvent;
@end

@implementation CardGameViewController

//lazy instantiation
- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

//getterszetter lazy instantiation
/*- (Deck *)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}*/
- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

/*- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount changed to %d", self.flipCount);
}*/


- (IBAction)touchCardButton:(UIButton *)sender
{
    /*if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        Card *randomCard = [self.deck drawRandomCard];
        if (randomCard){
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:randomCard.contents forState:UIControlStateNormal];
        }
        
    }*/
    self.switchGameMode.enabled=NO;
    long int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game choosenCardAtIndex:chosenButtonIndex];
    [self updateUI];
    
    //self.flipCount++;
}

//ujjateknal ujra inicializalunk es frissitunk
- (IBAction)redealButton:(UIButton *)sender {
    
    self.game=nil;
    self.switchGameMode.enabled=YES;
    self.lastEvent.text = [NSString stringWithFormat:@""];
    [self updateUI];
    
}
- (IBAction)gameMode:(UISwitch *)sender {
    
    if ([self.switchGameMode isOn]) {
        self.game.mode = 3;
        self.twoOrTree.text = [NSString stringWithFormat:@"%li card", (long)self.game.mode];
    }else{
        self.game.mode = 2;
        self.twoOrTree.text = [NSString stringWithFormat:@"%li card", (long)self.game.mode];
    }
    
}

- (void) viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logMessage:) name:@"lastEvent" object:nil];
}

- (void) logMessage:(NSNotification *) mess{
    //labell text beallit
    //NSLog([mess object]);
    //self.lastEvent.text = [NSString stringWithFormat:@"%@ valami", [mess object]];
    self.lastEvent.text = [mess object];
}






- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        long int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardtAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
