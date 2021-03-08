//
//  ViewController.m
//  Cryptography_1
//
//  Created by Admin on 05.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

#import "ViewController.h"
#import "Playfair.h"
#import "RailwayFence.h"
#import "ColumnarTransposition.h"
#import "TurningGrille.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *PlayfairField;
@property (weak, nonatomic) IBOutlet UITextField *PlayfairKeyField;
@property (weak, nonatomic) IBOutlet UISwitch *PlayfairSwitch;
@property (weak, nonatomic) IBOutlet UIButton *PlayfairSubmittButton;

@property (weak, nonatomic) IBOutlet UITextView *railwayFenceField;
@property (weak, nonatomic) IBOutlet UIStepper *railwayFenceRowStepper;
@property (weak, nonatomic) IBOutlet UILabel *railwayFenceRowLabel;
@property (weak, nonatomic) IBOutlet UIButton *railwayFenceSubmitButton;
@property (weak, nonatomic) IBOutlet UISwitch *railwayFenceSwitch;

@property (weak, nonatomic) IBOutlet UITextView *columnarTranspositionField;
@property (weak, nonatomic) IBOutlet UITextField *columnarTranspositionKeyField;
@property (weak, nonatomic) IBOutlet UIButton *columnarTranspositionButton;
@property (weak, nonatomic) IBOutlet UISwitch *columnarTranspositionSwitch;

@property (weak, nonatomic) IBOutlet UIButton *grilleButton;
@property (weak, nonatomic) IBOutlet UITextView *grilleField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PlayfairSubmittButton.layer.cornerRadius = 7;
    self.railwayFenceSubmitButton.layer.cornerRadius = 7;
    self.columnarTranspositionButton.layer.cornerRadius = 7;
    self.grilleButton.layer.cornerRadius = 7;
    
}
- (IBAction)submitPlayfairCypherization:(id)sender {
    if ([[self.PlayfairKeyField text] isEqualToString:@""])
        return;
    if ([[self.PlayfairField text] isEqualToString:@""])
        return;
    Playfair* cryptographer = [[Playfair alloc] initWithKey:[self.PlayfairKeyField text]];
    NSString* myString = [NSString new];
    if (self.PlayfairSwitch.on)
        myString=[cryptographer decypher:[self.PlayfairField text]];
    else
        myString= [cryptographer cypher:[self.PlayfairField text]];
    [self.PlayfairField setText:myString];
}

- (IBAction)railwayFenceRowsStepperValueChanged:(id)sender {
    [self.railwayFenceRowLabel setText: [NSString stringWithFormat:@"%d", (int) self.railwayFenceRowStepper.value]];
    
}
- (IBAction)submitRailwayCypherization:(id)sender {
    RailwayFence* cryptographer = [[RailwayFence alloc] initWithNumberOfRows:(int) self.railwayFenceRowStepper.value];
    NSString* myString = [NSString new];
    if (self.railwayFenceSwitch.on)
        myString=[cryptographer decypher:[self.railwayFenceField text]];
    else
        myString= [cryptographer cypher:[self.railwayFenceField  text]];
    [self.railwayFenceField setText:myString];
}
- (IBAction)submitColumnarTransposition:(id)sender {
    ColumnarTransposition* cryptographer = [[ColumnarTransposition alloc] initWithKey:self.columnarTranspositionKeyField.text];
    NSString* myString = [NSString new];
        if (self.columnarTranspositionSwitch.on)
        myString=[cryptographer decypher:[self.columnarTranspositionField text]];
    else
        myString= [cryptographer cypher:[self.columnarTranspositionField  text]];
    [self.columnarTranspositionField setText:myString];
}
- (IBAction)submitGrilleCypherization:(id)sender {
    TurningGrille* cryptographer = [TurningGrille new];
    [self.grilleField setText:[cryptographer cypher:self.grilleField.text]];
}

@end
