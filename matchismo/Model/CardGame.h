//
//  CardGame.h
//  matchismo
//
//  Created by Pierre Thelusma on 9/24/13.
//  Copyright (c) 2013 Pierre Thelusma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardGame : NSObject

@property (nonatomic) int score;
@property (nonatomic) int flips;

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (Card *)cardAtIndex:(NSUInteger)index;

- (NSMutableArray *) cards;

- (NSMutableArray *) results;



@end
