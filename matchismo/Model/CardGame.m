//
//  CardGame.m
//  matchismo
//
//  Created by Pierre Thelusma on 9/24/13.
//  Copyright (c) 2013 Pierre Thelusma. All rights reserved.
//

#import "CardGame.h"
#import "Deck.h"

@interface CardGame()

@property (strong, nonatomic) NSMutableArray *cards;
@property (strong, nonatomic) NSMutableArray *results;

@end

@implementation CardGame

@synthesize score;
@synthesize flips;

-(id)init
{
    self.score = 0;
    self.flips = 0;
    
    return self;
}

- (NSMutableArray *) cards
{
    if(!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
    
}

- (NSMutableArray *) results
{
    if(!_results)
    {
        _results = [[NSMutableArray alloc] init];
        
        [_results addObject:@"none"];
    }
    
    return _results;
    
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self)
    {
        for(int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if(!card)
            {
                self = nil;
                break;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count] ? self.cards[index] : nil);
}

@end
