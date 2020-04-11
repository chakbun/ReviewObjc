//
//  Employee.h
//  HelloObjc
//
//  Created by jaben on 2020/4/11.
//  Copyright © 2020 Jaben. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department;

NS_ASSUME_NONNULL_BEGIN

@interface Employee : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "Employee+CoreDataProperties.h"
