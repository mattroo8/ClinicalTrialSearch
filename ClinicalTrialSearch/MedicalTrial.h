//
//  MedicalTrial.h
//  ClinicalTrialSearch
//
//  Created by matt rooney on 26/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MedicalTrialDetail.h"

@interface MedicalTrial : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSArray *phases;
@property (strong, nonatomic) NSArray *countries;
@property (strong, nonatomic) NSString *updatedTime;
@property (strong, nonatomic) NSString *URL;
@property (strong, nonatomic) MedicalTrialDetail *detail;

@end
