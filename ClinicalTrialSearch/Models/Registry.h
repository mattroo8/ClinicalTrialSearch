//
//  Registry.h
//  ClinicalTrialSearch
//
//  Created by matt rooney on 08/01/2017.
//  Copyright © 2017 matt rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Registry : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *registered_at;
@property (strong, nonatomic) NSString *modified_at;
@property (strong, nonatomic) NSString *attribution;

@end
