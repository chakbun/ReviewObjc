//
//  Employee+CoreDataProperties.m
//  HelloObjc
//
//  Created by jaben on 2020/4/11.
//  Copyright © 2020 Jaben. All rights reserved.
//
//

#import "Employee+CoreDataProperties.h"

@implementation Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
}

@dynamic age;
@dynamic name;
@dynamic sn;
@dynamic department;

@end
