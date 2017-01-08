//
//  HTTPHelper.h
//  ClinicalTrialSearch
//
//  Created by matt rooney on 25/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPHelper : NSObject <NSURLConnectionDelegate>

+(void)searchForDisease:(NSString *)diseaseName withNotificationName:(NSString *)notificationName;
+(void)getDetailsForDiseaseId:(NSString *)diseaseId withNotificationName:(NSString *)notificationName;
+(void)searchMedicalTrial:(NSString *)trialName withNotificationName:(NSString *)notificationName;
+(void)searchMedicalTrialDetail:(NSString *)trialId withNotificationName:(NSString *)notificationName;

@end
