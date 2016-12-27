//
//  DiseaseDetail.h
//  ClinicalTrialSearch
//
//  Created by matt rooney on 26/12/2016.
//  Copyright © 2016 matt rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mesh.h"

@interface DiseaseDetail : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *diseaseDescription;
@property (strong, nonatomic) Mesh *mesh;

@end
