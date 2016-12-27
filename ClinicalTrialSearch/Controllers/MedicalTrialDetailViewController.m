//
//  MedicalTrialDetailViewController.m
//  ClinicalTrialSearch
//
//  Created by matt rooney on 26/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import "MedicalTrialDetailViewController.h"
#import "HTTPSearchDiseases.h"

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

-(void)setTextViewTextAndStopLoading:(MedicalTrialDetail *)trialDetail {
    _titleLabel.text = trialDetail.name;
    [_summaryTextView setValue:trialDetail.summary forKey:@"contentToHTMLString"];
    [_descriptionTextView setValue:trialDetail.desc forKey:@"contentToHTMLString"];
//    [_spinner stopAnimating];
//    _spinner.hidden = YES;
}

@end
