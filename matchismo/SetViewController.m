//
//  SetViewController.m
//  matchismo
//
//  Created by Pierre Thelusma on 9/22/13.
//  Copyright (c) 2013 Pierre Thelusma. All rights reserved.
//

#import "SetViewController.h"
#import "SetCardGame.h"
#import "SetPlayingCardDeck.h"
#import <QuartzCore/QuartzCore.h>
#import "SetPlayingCard.h"
#import "ScoreViewController.h"
#import "Score.h"

@interface SetViewController ()
@property (strong, nonatomic) SetCardGame *game;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblFlips;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (strong, nonatomic) NSUserDefaults *defaults;

//@property (strong, nonatomic) NSMutableArray *scores;

@end

@implementation SetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
    }
    return self;
}

- (NSUserDefaults *) defaults
{
    if(!_defaults)
    {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    
    return _defaults;
    
}

- (SetCardGame *) game
{
    if(!_game)
    {
        _game = [[SetCardGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetPlayingCardDeck alloc] init]];
    }
    
    return _game;
}

- (void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void) updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        SetPlayingCard *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setAttributedTitle:card.contents forState:UIControlStateNormal];
        
        if(card.selected)
        {
            [cardButton setBackgroundColor:[UIColor lightGrayColor]];
        }
        else
        {
            [cardButton setBackgroundColor:[UIColor whiteColor]];
        }
        
        cardButton.enabled = !card.unplayable;
        cardButton.alpha = card.unplayable ? 0.3 : 1.0;
        
        self.lblScore.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        
        self.lblFlips.text = [NSString stringWithFormat:@"Flips: %d", self.game.flips];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    for(UIButton *cardButton in self.cardButtons)
    {
        [[cardButton layer] setBorderWidth:0.5f];
        [[cardButton layer] setBorderColor:[UIColor blackColor].CGColor];
    }
    
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deal:(id)sender
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd 'at' HH:mm.ssss"];
    NSDate *now = [[NSDate alloc] init];
    
    Score *score = [[Score alloc] init];
    
    score.score = self.game.score;
    score.game = @"Set";
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
    
    self.game = nil;
    [self updateUI];
}

- (IBAction)selectCard:(UIButton *)sender
{
    
    [self.game selectCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
    
}

@end
