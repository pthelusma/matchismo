//
//  CardGameViewController.m
//  matchismo
//
//  Created by Pierre Thelusma on 9/12/13.
//  Copyright (c) 2013 Pierre Thelusma. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISegmentedControl *GameMode;
@property (nonatomic) NSInteger mode;
@property (strong, nonatomic) NSMutableArray *flipResultsArray;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UISlider *resultsSlider;
@end

@implementation CardGameViewController

- (CardMatchingGame *) game
{
    if(!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init] usingMode:self.mode];
    }
    
    return _game;
}


- (NSMutableArray *) flipResultsArray
{
    if(!_flipResultsArray)
    {
        _flipResultsArray = [[NSMutableArray alloc] init];
    }
    
    return _flipResultsArray;
}

- (IBAction)slideResults:(id)sender {
    UISlider * slider = (UISlider*) sender;
    
    int sliderIndex = [slider value]-1;
    
    if(self.flipResultsArray.count)
    {
        self.resultsLabel.text = [NSString stringWithFormat:@"Results: %@", [self.flipResultsArray objectAtIndex:sliderIndex]];
    }
    
    if(sliderIndex != (self.flipResultsArray.count-1))
        self.resultsLabel.alpha = 0.3;
    else 
        self.resultsLabel.alpha = 1;
    
}

- (NSInteger) mode
{
    if(!_mode)
    {
        _mode = 0;
    }
    
    return _mode;
}

- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes"])
    {
        self.flipCount = 0;
        [self.resultsSlider setMaximumValue:0];
        self.flipResultsArray = [[NSMutableArray alloc] init];
        
        self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init] usingMode:self.mode];
        
        [self updateUI];
        
        [self enableGameModeUISegmentedControl];
    }
}

- (void) updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"326.png"];
    
    for(UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        if(card.isFaceUp)
        {
        [cardButton setImage:nil
                    forState:UIControlStateNormal];
        }
        else
        {
            [cardButton setImage:cardBackImage
                        forState:UIControlStateNormal];
        }
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    self.resultsLabel.text = [NSString stringWithFormat:@"Results: %@", self.game.lastFlipResults];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];

}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];    
    self.flipCount++;
    [self.resultsSlider setMaximumValue:[self.resultsSlider maximumValue] + 1];
    [self.resultsSlider setMinimumValue:1];
    [self.resultsSlider setValue:[self.resultsSlider maximumValue]];
    [self.flipResultsArray addObject:self.game.lastFlipResults];
    [self updateUI];
    [self disableGameModeUISegmentedControl];
}

- (void) enableGameModeUISegmentedControl
{
    if (!self.GameMode.enabled) {
        self.GameMode.enabled = YES;
    }
}

- (void) disableGameModeUISegmentedControl
{
    if (self.GameMode.enabled) {
        self.GameMode.enabled = NO;
    }
}

- (IBAction)changeGameMode:(id)sender {
    UISegmentedControl *gameModeUISegmentedControl = (UISegmentedControl *) sender;

    self.mode = [gameModeUISegmentedControl selectedSegmentIndex];
    
    [self.game setMode:self.mode];
    
}

- (IBAction)Deal:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deal?"
                                                    message:@"Are you sure you want to deal?"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Yes", @"No", nil];
    
    [alert show];

}

@end

