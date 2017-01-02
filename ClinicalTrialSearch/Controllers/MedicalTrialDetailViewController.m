//
//  MedicalTrialDetailViewController.m
//  ClinicalTrialSearch
//
//  Created by matt rooney on 26/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import "MedicalTrialDetailViewController.h"
#import "HTTPSearchDiseases.h"
#import "MedicalTrialOutcome.h"

@interface MedicalTrialDetailViewController ()

@end

@implementation MedicalTrialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trialDetailReceived:) name:@"trialDetailReceived" object:nil];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    [HTTPSearchDiseases searchMedicalTrialDetail:_trial.id];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)trialDetailReceived:(NSNotification *)notif
{
    dispatch_async (dispatch_get_main_queue(), ^{
        NSMutableDictionary *dict = [NSMutableDictionary new];
        dict = notif.object;
        _trial.detail = [dict objectForKey:@"detail"];
        [self setTextViewTextAndStopLoading:_trial.detail];
    });
}

-(void)setTextViewTextAndStopLoading:(MedicalTrialDetail *)trialDetail
{
    //Set the title
    _titleLabel.text = trialDetail.name;
    
    NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
    
    //Set the Summary text
    if(trialDetail.summary && trialDetail.summary.length > 0){
        NSMutableAttributedString *summaryString = [[NSMutableAttributedString alloc] initWithString:@"Summary\n"
                                                                                              attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]}];
        [attributedString appendAttributedString:summaryString];
        [attributedString appendAttributedString:[self convertHTMLToAtrributedString:trialDetail.summary]];
    }
    //Set the Description text
    if(trialDetail.desc && trialDetail.desc.length > 0){
        NSMutableAttributedString *descriptionString = [[NSMutableAttributedString alloc] initWithString:@"\n\nDescription\n"
                                                                                              attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]}];
        [attributedString appendAttributedString:descriptionString];
        [attributedString appendAttributedString:[self convertHTMLToAtrributedString:trialDetail.desc]];
    }
    _textView.attributedText = attributedString;
    
//    NSString *outcomeString = @"";
//    for(MedicalTrialOutcome *outcome in trialDetail.outcomes){
//        outcomeString = [NSString stringWithFormat:@"Outcome Type: %@\nDescription: %@\nMeasure: %@\n\n", outcome.outcomeType, outcome.desc, outcome.measure];
//        _outcomeTextView.text = [_outcomeTextView.text stringByAppendingString:outcomeString];
//    }
}

-(NSMutableAttributedString *)convertHTMLToAtrributedString:(NSString *)HTML
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                            initWithData: [HTML dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}

@end
