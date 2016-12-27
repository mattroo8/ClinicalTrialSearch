//
//  HTTPSearchDiseases.m
//  ClinicalTrialSearch
//
//  Created by matt rooney on 25/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import "HTTPSearchDiseases.h"
#import "Disease.h"
#import "DiseaseDetail.h"
#import "Mesh.h"
#import "MedicalTrial.h"

@implementation HTTPSearchDiseases

+(void)searchForDisease:(NSString *)diseaseName
{
    //Create the URL componenets
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [components setHost:@"ws.mytomorrows.com"];
    [components setQuery:[NSString stringWithFormat:@"q=%@", diseaseName]];
    [components setPath:@"/api/v1/diseases/autocomplete"];
    
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[components URL]];
    // Create url connection and fire request
    NSURLSessionDataTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData *data,
                                                        NSURLResponse *response,
                                                        NSError *error) {
                                        if (!error) {
                                            // Success
                                            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                NSError *jsonError;
                                                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                                
                                                if (jsonError) {
                                                    // Error Parsing JSON
                                                    
                                                } else {
                                                    NSMutableArray *diseasesResponse = [NSMutableArray new];
                                                    diseasesResponse = [[jsonResponse objectForKey:@"data"] objectForKey:@"diseases"];
                                                    NSMutableArray *diseases = [NSMutableArray new];
                                                    for (id diseaseResponse in diseasesResponse){
                                                        Disease *disease = [Disease new];
                                                        disease.id = [diseaseResponse objectForKey:@"id"];
                                                        disease.name = [diseaseResponse objectForKey:@"name"];
//                                                        NSMutableDictionary *meshDict = [diseaseResponse objectForKey:@"mesh"];
//                                                        disease.mesh = [Mesh new];
//                                                        disease.mesh.heading = [meshDict objectForKey:@"heading"];
//                                                        disease.mesh.treeNumber = [meshDict objectForKey:@"treeNumber"];
                                                        [diseases addObject:disease];
                                                    }
                                                    NSLog(@"Test");
                                                    NSMutableDictionary *notificationDict = [NSMutableDictionary new];
                                                    [notificationDict setObject:diseases forKey:@"diseases"];
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"diseasesReceived" object:notificationDict];
                                                }
                                            }  else {
                                                //Web server is returning an error
                                            }
                                        } else {
                                            // Fail
                                            NSLog(@"error : %@", error.description);
                                        }
                                    }];
    [task resume];
}

+(void)getDetailsForDiseaseId:(NSString *)diseaseId
{
    //Create the URL componenets
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [components setHost:@"ws.mytomorrows.com"];
    [components setPath:[NSString stringWithFormat:@"/api/v1/diseases/%@", diseaseId]];
    
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[components URL]];
    // Create url connection and fire request
    NSURLSessionDataTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData *data,
                                                        NSURLResponse *response,
                                                        NSError *error) {
                                        if (!error) {
                                            // Success
                                            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                NSError *jsonError;
                                                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                                
                                                if (jsonError) {
                                                    // Error Parsing JSON
                                                    
                                                } else {
                                                    NSLog(@"Test");
                                                    NSMutableDictionary *diseasesResponse = [NSMutableDictionary new];
                                                    diseasesResponse = [jsonResponse objectForKey:@"data"];
                                                    
                                                    DiseaseDetail *diseaseDetail = [DiseaseDetail new];
                                                    diseaseDetail.id = [diseasesResponse objectForKey:@"id"];
                                                    diseaseDetail.diseaseDescription = [diseasesResponse objectForKey:@"description"];
//                                                    NSMutableDictionary *meshDict = [diseasesResponse objectForKey:@"mesh"];
//                                                    diseaseDetail.mesh = [Mesh new];
//                                                    diseaseDetail.mesh.heading = [meshDict objectForKey:@"heading"];
//                                                    diseaseDetail.mesh.treeNumber = [meshDict objectForKey:@"treeNumber"];
                                                    diseaseDetail.name = [diseasesResponse objectForKey:@"name"];
                                                    
                                                    NSMutableDictionary *notificationDict = [NSMutableDictionary new];
                                                    [notificationDict setObject:diseaseDetail forKey:@"diseaseDetail"];
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"diseaseDetailReceived" object:notificationDict];
                                                }
                                            }  else {
                                                //Web server is returning an error
                                            }
                                        } else {
                                            // Fail
                                            NSLog(@"error : %@", error.description);
                                        }
                                    }];
    [task resume];
}

+(void)searchMedicalTrial:(NSString *)trialName
{
    //Create the URL componenets
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [components setHost:@"ws.mytomorrows.com"];
    [components setQuery:[NSString stringWithFormat:@"query=%@", trialName]];
    [components setPath:@"/api/v1/medical_trials"];
    
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[components URL]];
    // Create url connection and fire request
    NSURLSessionDataTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData *data,
                                                        NSURLResponse *response,
                                                        NSError *error) {
                                        if (!error) {
                                            // Success
                                            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                NSError *jsonError;
                                                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                                
                                                if (jsonError) {
                                                    // Error Parsing JSON
                                                    
                                                } else {
                                                    NSLog(@"Test");
                                                    NSMutableArray *trials = [NSMutableArray new];
                                                    NSMutableArray *trialsResponse = [NSMutableArray new];
                                                    trialsResponse = [[jsonResponse objectForKey:@"data"] objectForKey:@"medical_trials"];
                                                    for (id trialDict in trialsResponse){
                                                        MedicalTrial *trial = [MedicalTrial new];
                                                        trial.id = [trialDict objectForKey:@"id"];
                                                        trial.name = [trialDict objectForKey:@"name"];
                                                        [trials addObject:trial];
                                                    }
                                                    NSMutableDictionary *notificationDict = [NSMutableDictionary new];
                                                    [notificationDict setObject:trials forKey:@"trials"];
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"trialsReceived" object:notificationDict];
                                                }
                                            }  else {
                                                //Web server is returning an error
                                            }
                                        } else {
                                            // Fail
                                            NSLog(@"error : %@", error.description);
                                        }
                                    }];
    [task resume];
}

+(void)searchMedicalTrialDetail:(NSString *)trialId
{
    //Create the URL componenets
    NSURLComponents *components = [NSURLComponents new];
    [components setScheme:@"https"];
    [components setHost:@"ws.mytomorrows.com"];
    [components setPath:[NSString stringWithFormat:@"/api/v1/medical_trials/%@", trialId]];
    
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[components URL]];
    // Create url connection and fire request
    NSURLSessionDataTask *task =
    [[NSURLSession sharedSession] dataTaskWithRequest:request
                                    completionHandler:^(NSData *data,
                                                        NSURLResponse *response,
                                                        NSError *error) {
                                        if (!error) {
                                            // Success
                                            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                NSError *jsonError;
                                                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                                
                                                if (jsonError) {
                                                    // Error Parsing JSON
                                                    
                                                } else {
                                                    NSLog(@"Test");
                                                    NSMutableDictionary *diseasesResponse = [NSMutableDictionary new];
                                                    diseasesResponse = [jsonResponse objectForKey:@"data"];
                                                    MedicalTrialDetail *detail = [MedicalTrialDetail new];
                                                    detail.id = [diseasesResponse objectForKey:@"id"];
                                                    detail.name = [diseasesResponse objectForKey:@"title"];
                                                    detail.summary = [diseasesResponse objectForKey:@"summary"];
                                                    detail.desc = [diseasesResponse objectForKey:@"description"];

                                                    NSMutableDictionary *notificationDict = [NSMutableDictionary new];
                                                    [notificationDict setObject:detail forKey:@"detail"];
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"trialDetailReceived" object:notificationDict];
                                                }
                                            }  else {
                                                //Web server is returning an error
                                            }
                                        } else {
                                            // Fail
                                            NSLog(@"error : %@", error.description);
                                        }
                                    }];
    [task resume];
}
@end
