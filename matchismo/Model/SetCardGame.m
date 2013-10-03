//
//  SetCardGame.m
//  matchismo
//
//  Created by Pierre Thelusma on 9/24/13.
//  Copyright (c) 2013 Pierre Thelusma. All rights reserved.
//

#import "SetCardGame.h"
#import "Card.h"
#import "SetPlayingCard.h"

@implementation SetCardGame

-(id)init
{
    self = [super init];

    return self;
}

- (void)selectCardAtIndex:(NSUInteger)index
{
    
    SetPlayingCard *card = [self cardAtIndex:index];
    
    if(!card.unplayable)
    {
        if(!card.selected)
        {
            card.selected = YES;
            self.score -= 1;
            self.flips += 1;
            
            if([[self getSelectedCards] count] == 3)
            {
                int matchScore = [self scoring];
                if(matchScore)
                {
                    [self setSelectedCardsUnplayable];
                    self.score += matchScore;
                    
                    [[self results] addObject:@"Match!"];
                }
                else
                {
                    [self setSelectedCardsSelected];
                    [[self results] addObject:@"No match!"];
                }
            }
        } else
        {
            card.selected = NO;
        }
    }

}

-(NSMutableArray *) getSelectedCards
{
    NSMutableArray *selectedCards = [[NSMutableArray alloc] init];
    
    for(SetPlayingCard* card in [super cards])
    {
        if(card.selected && !card.unplayable)
        {
            [selectedCards addObject:card];
        }
    }
    
    return selectedCards;
    
}

-(void) setSelectedCardsUnplayable
{
    for(SetPlayingCard* selectedCard in [self getSelectedCards])
    {
        selectedCard.unplayable = YES;
    }
}

-(void) setSelectedCardsSelected
{
    for(SetPlayingCard* selectedCard in [self getSelectedCards])
    {
        selectedCard.selected = NO;
    }
}

- (NSInteger) scoring
{
    int score = 0;
    
    if(([self hasSameNumber] || [self hasDistinctNumber]) && ([self hasSameSymbol] || [self hasDistinctSymbol]) && ([self hasSameColor] || [self hasDistinctColor]) && ([self hasSameShading] || [self hasDistinctShading]))
    {
        score = 5;
    }
    
    return score;
}

-(BOOL) hasSameNumber
{
    int x = [[[self getSelectedCards] objectAtIndex:0] number];
    int y = [[[self getSelectedCards] objectAtIndex:1] number];
    int z = [[[self getSelectedCards] objectAtIndex:2] number];

    return (x == y && y == z);
}


-(BOOL) hasSameSymbol
{
    NSString *x = [[[self getSelectedCards] objectAtIndex:0] symbol];
    NSString *y = [[[self getSelectedCards] objectAtIndex:1] symbol];
    NSString *z = [[[self getSelectedCards] objectAtIndex:2] symbol];
    
    return ([x isEqualToString:y] && [y isEqualToString:z]);
}

-(BOOL) hasSameShading
{
    NSString *x = [[[self getSelectedCards] objectAtIndex:0] shade];
    NSString *y = [[[self getSelectedCards] objectAtIndex:1] shade];
    NSString *z = [[[self getSelectedCards] objectAtIndex:2] shade];
    
    return ([x isEqualToString:y] && [y isEqualToString:z]);
}

-(BOOL) hasSameColor
{
    UIColor *x = [[[self getSelectedCards] objectAtIndex:0] color];
    UIColor *y = [[[self getSelectedCards] objectAtIndex:1] color];
    UIColor *z = [[[self getSelectedCards] objectAtIndex:2] color];
    
    return ([x isEqual:y] && [y isEqual:z]);
}

-(BOOL) hasDistinctNumber
{
    int x = [[[self getSelectedCards] objectAtIndex:0] number];
    int y = [[[self getSelectedCards] objectAtIndex:1] number];
    int z = [[[self getSelectedCards] objectAtIndex:2] number];
    
    return (x != y && y != z && x != z);
}

-(BOOL) hasDistinctSymbol
{
    NSString *x = [[[self getSelectedCards] objectAtIndex:0] symbol];
    NSString *y = [[[self getSelectedCards] objectAtIndex:1] symbol];
    NSString *z = [[[self getSelectedCards] objectAtIndex:2] symbol];
    
    return (![x isEqualToString:y] && ![y isEqualToString:z] && ![x isEqualToString:z]);
}

-(BOOL) hasDistinctShading
{
    NSString *x = [[[self getSelectedCards] objectAtIndex:0] shade];
    NSString *y = [[[self getSelectedCards] objectAtIndex:1] shade];
    NSString *z = [[[self getSelectedCards] objectAtIndex:2] shade];
    
    return (![x isEqualToString:y] && ![y isEqualToString:z] && ![x isEqualToString:z]);
}

-(BOOL) hasDistinctColor
{
    UIColor *x = [[[self getSelectedCards] objectAtIndex:0] color];
    UIColor *y = [[[self getSelectedCards] objectAtIndex:1] color];
    UIColor *z = [[[self getSelectedCards] objectAtIndex:2] color];
    
    return (![x isEqual:y] && ![y isEqual:z] && ![x isEqual:z]);
}


@end
