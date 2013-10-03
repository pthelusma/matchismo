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
#import "ScoreViewController.h"
#import "Score.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UISlider *resultsSlider;


@property (strong, nonatomic) NSUserDefaults *defaults;

@property (strong, nonatomic) NSMutableArray *scores;

@end

@implementation CardGameViewController

- (NSMutableArray *) scores
{
    if(!_scores)
    {
        _scores = [[NSMutableArray alloc] init];
    }
    
    return _scores;
    
}

- (NSUserDefaults *) defaults
{
    if(!_defaults)
    {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    
    return _defaults;
    
}

- (void) viewWillLoad
{
    [self.resultsSlider setMinimumValue:1];
    
    [self.resultsSlider setMaximumValue:1];
    
    [self.resultsSlider setValue:1];
    
}


- (CardMatchingGame *) game
{
    if(!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    }
    
    return _game;
}


- (IBAction)slideResults:(id)sender {
    UISlider * slider = (UISlider*) sender;
    
    int sliderIndex = [slider value];
    
    if(self.game.results.count)
    {
        self.resultsLabel.text = [NSString stringWithFormat:@"Results: %@", [self.game.results objectAtIndex:sliderIndex]];
    }
    
    if(sliderIndex != (self.game.results.count-1))
        self.resultsLabel.alpha = 0.3;
    else 
        self.resultsLabel.alpha = 1;
    
}

- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm.ssss"];
    NSDate *now = [[NSDate alloc] init];
    
    Score *score = [[Score alloc] init];
    
    score.score = self.game.score;
    score.game = @"Match";
    score.date = [dateFormatter stringFromDate:now];
    
    NSString *scoreString = [NSString stringWithFormat:@"[%@][%@] Score: %d\n", score.game,score.date, score.score];
    
    NSMutableArray *scores = [[NSMutableArray alloc] init];
    
    if([self.defaults objectForKey:@"Scores"])
    {
        for(NSString *thing in [self.defaults objectForKey:@"Scores"])
        {
            [scores addObject:thing];
        }
        
        [scores addObject:scoreString];
        [self.defaults setObject:scores forKey:@"Scores"];
    }
    else
    {
        [scores addObject:scoreString];
        [self.defaults setObject:scores forKey:@"Scores"];
    }
    
    [self.defaults synchronize];
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes"])
    {
        [self.resultsSlider setMaximumValue:0];
        self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
        
        [self updateUI];

    }
}

- (void) updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"326.png"];
    
    for(UIButton *cardButton in self.cardButtons)
    {
        PlayingCard *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        if(card.faceUp)
        {
        [cardButton setImage:nil
                    forState:UIControlStateNormal];
        }
        else
        {
            [cardButton setImage:cardBackImage
                        forState:UIControlStateNormal];
        }
        
        cardButton.selected = card.faceUp;
        cardButton.enabled = !card.unplayable;
        cardButton.alpha = card.unplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    self.resultsLabel.text = [NSString stringWithFormat:@"Results: %@", [self.game.results objectAtIndex:self.game.results.count - 1]];

    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.game.flips];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];    
    [self.resultsSlider setMaximumValue:[self.resultsSlider maximumValue] + 1];
    [self.resultsSlider setValue:[self.resultsSlider maximumValue]];
    [self updateUI];
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

