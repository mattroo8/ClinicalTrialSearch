//
//  Disease.h
//  ClinicalTrialSearch
//
//  Created by matt rooney on 25/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiseaseDetail.h"
#import "Mesh.h"

@interface Disease : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) Mesh *mesh;
@property (strong, nonatomic) DiseaseDetail *detail;

@end
