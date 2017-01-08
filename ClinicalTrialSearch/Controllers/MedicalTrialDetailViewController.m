//
//  MedicalTrialDetailViewController.m
//  ClinicalTrialSearch
//
//  Created by matt rooney on 26/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import "MedicalTrialDetailViewController.h"
#import "HTTPHelper.h"
#import "MedicalTrialOutcome.h"
#import "Registry.h"

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
    [_spinner startAnimating];
    _spinner.hidden = NO;
    [HTTPHelper searchMedicalTrialDetail:_trial.id withNotificationName:@"trialDetailReceived"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)trialDetailReceived:(NSNotification *)notif
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
            _trial.detail = [notif.object objectForKey:@"detail"];
            [self setTextViewText:_trial.detail];
        }
    });
}

-(void)setTextViewText:(MedicalTrialDetail *)trialDetail
{
    [_spinner stopAnimating];
    _spinner.hidden = YES;
    
    //Set the title
    _titleLabel.text = trialDetail.name;
    
    NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
    
    //Set the Summary text
    if(trialDetail.summary && trialDetail.summary.length > 0){
        NSMutableAttributedString *summaryString = [[NSMutableAttributedString alloc] initWithString:@"Summary\n"
                                                                                              attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]}];
        [attributedString appendAttributedString:summaryString];
        [attributedString appendAttributedString:[MedicalTrialDetailViewController convertHTMLToAtrributedString:trialDetail.summary]];
    }
    //Set the Description text
    if(trialDetail.desc && trialDetail.desc.length > 0){
        NSMutableAttributedString *descriptionString = [[NSMutableAttributedString alloc] initWithString:@"\n\nDescription\n"
                                                                                              attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]}];
        [attributedString appendAttributedString:descriptionString];
        [attributedString appendAttributedString:[MedicalTrialDetailViewController convertHTMLToAtrributedString:trialDetail.desc]];
    }
    if(trialDetail.outcomes && [trialDetail.outcomes count]>0){
        NSMutableAttributedString *outcomeString = [[NSMutableAttributedString alloc] initWithString:@"\n\nOutcomes"
                                                                                              attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]}];
        [attributedString appendAttributedString:outcomeString];

        for(MedicalTrialOutcome *outcome in trialDetail.outcomes){
            if(outcome.outcomeType){
                NSMutableAttributedString *outcomeType = [[NSMutableAttributedString alloc] initWithString:@"\nType: "
                                                                                                  attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12]}];
                [attributedString appendAttributedString:outcomeType];
                [attributedString appendAttributedString:[MedicalTrialDetailViewController convertHTMLToAtrributedString:outcome.outcomeType]];
            }
            if(outcome.timeFrame){
                NSMutableAttributedString *outcomeTimeFrame = [[NSMutableAttributedString alloc] initWithString:@"\nTime Frame: "
                                                                                                attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12]}];
                [attributedString appendAttributedString:outcomeTimeFrame];
                [attributedString appendAttributedString:[MedicalTrialDetailViewController convertHTMLToAtrributedString:outcome.timeFrame]];
            }
            if(outcome.measure){
                NSMutableAttributedString *outcomeMeasure = [[NSMutableAttributedString alloc] initWithString:@"\nMeasure: "
                                                                                                attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12]}];
                [attributedString appendAttributedString:outcomeMeasure];
                [attributedString appendAttributedString:[MedicalTrialDetailViewController convertHTMLToAtrributedString:outcome.measure]];
            }
            [attributedString appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"\n"]];
        }
    }
    if(trialDetail.registries && [trialDetail.registries count]>0){
        NSMutableAttributedString *sourcesString = [[NSMutableAttributedString alloc] initWithString:@"\n\nSources"
                                                                                          attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]}];
        [attributedString appendAttributedString:sourcesString];

        
        for(Registry *registry in trialDetail.registries){
            if((registry.name && [registry.name class] != [NSNull class]) && (registry.url && [registry.url class] != [NSNull class])){
                NSMutableAttributedString *registryName = [[NSMutableAttributedString alloc] initWithString:@"\nName: "
                                                                                                   attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12]}];
                [attributedString appendAttributedString:registryName];
                [attributedString appendAttributedString:[[NSAttributedString alloc]initWithString:registry.name]];
                
                NSMutableAttributedString *registryUrl = [[NSMutableAttributedString alloc] initWithString:@"\nurl: "
                                                                                                 attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12]}];
                [attributedString appendAttributedString:registryUrl];
                [attributedString appendAttributedString:[[NSAttributedString alloc]initWithString:registry.url]];
            }
        }
    }
    _textView.attributedText = attributedString;
}

+(NSMutableAttributedString *)convertHTMLToAtrributedString:(NSString *)HTML
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
