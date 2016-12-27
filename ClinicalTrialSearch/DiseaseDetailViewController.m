//
//  DiseaseDetailViewController.m
//  ClinicalTrialSearch
//
//  Created by matt rooney on 26/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import "DiseaseDetailViewController.h"
#import "HTTPSearchDiseases.h"

@interface DiseaseDetailViewController ()

@end

@implementation DiseaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(diseaseDetailReceived:) name:@"diseaseDetailReceived" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    if(_isDiseaseDetail){
        if(!_disease.detail.diseaseDescription && _disease.detail.diseaseDescription.length==0){
            [HTTPSearchDiseases getDetailsForDiseaseId:_disease.id];
            [_spinner startAnimating];
            _spinner.hidden = NO;
        } else {
            [self setTextViewTextAndStopLoading:_disease.detail.diseaseDescription];
        }
    } 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)diseaseDetailReceived:(NSNotification *)notif
{
    dispatch_async (dispatch_get_main_queue(), ^{
        NSMutableDictionary *dict = [NSMutableDictionary new];
        dict = notif.object;
        _disease.detail = [DiseaseDetail new];
        _disease.detail = [dict objectForKey:@"diseaseDetail"];
        [self setTextViewTextAndStopLoading:_disease.detail.diseaseDescription];
    });
}

-(void)setTextViewTextAndStopLoading:(NSString *)text {
    [_textView setValue:text forKey:@"contentToHTMLString"];
    _textView.font = [UIFont fontWithName:@"vardana" size:100.0];
    [_spinner stopAnimating];
    _spinner.hidden = YES;
}

@end
