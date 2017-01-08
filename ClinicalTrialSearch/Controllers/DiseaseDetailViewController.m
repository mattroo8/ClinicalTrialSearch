//
//  DiseaseDetailViewController.m
//  ClinicalTrialSearch
//
//  Created by matt rooney on 26/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import "DiseaseDetailViewController.h"
#import "HTTPHelper.h"
#import "MedicalTrialDetailViewController.h"

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
    if(!_disease.detail.diseaseDescription && _disease.detail.diseaseDescription.length==0){
        [HTTPHelper getDetailsForDiseaseId:_disease.id withNotificationName:@"diseaseDetailReceived"];
        [_spinner startAnimating];
        _spinner.hidden = NO;
    } else {
        [_spinner stopAnimating];
        _spinner.hidden = YES;
        [self setTextViewText:_disease.detail.diseaseDescription];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)diseaseDetailReceived:(NSNotification *)notif
{
    dispatch_async (dispatch_get_main_queue(), ^{
        
        [_spinner stopAnimating];
        _spinner.hidden = YES;
        
        NSError *error;
        if((error = (NSError *)[notif.object objectForKey:@"error"])){

            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:[error.userInfo objectForKey:@"NSLocalizedDescription"]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [self.navigationController popViewControllerAnimated:YES];
                                                                  }];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            _disease.detail = [DiseaseDetail new];
            _disease.detail = [notif.object objectForKey:@"diseaseDetail"];
            [self setTextViewText:_disease.detail.diseaseDescription];
        }
    });
}

-(void)setTextViewText:(NSString *)text {
    
    NSMutableAttributedString *detailText = [MedicalTrialDetailViewController convertHTMLToAtrributedString:text];
    _textView.attributedText = detailText;
}

@end
