//
//  HTTPHelper.h
//  ClinicalTrialSearch
//
//  Created by matt rooney on 25/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPHelper : NSObject <NSURLConnectionDelegate>

+(void)searchForDisease:(NSString *)diseaseName;
+(void)getDetailsForDiseaseId:(NSString *)diseaseId;
+(void)searchMedicalTrial:(NSString *)trialName;
+(void)searchMedicalTrialDetail:(NSString *)trialId;

@end
