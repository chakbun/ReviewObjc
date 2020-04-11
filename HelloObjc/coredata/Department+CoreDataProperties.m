//
//  Department+CoreDataProperties.m
//  HelloObjc
//
//  Created by jaben on 2020/4/11.
//  Copyright © 2020 Jaben. All rights reserved.
//
//

#import "Department+CoreDataProperties.h"

@implementation Department (CoreDataProperties)

+ (NSFetchRequest<Department *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Department"];
}

@dynamic name;
@dynamic sn;
@dynamic employee;

@end
