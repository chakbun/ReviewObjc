//
//  Employee+CoreDataProperties.h
//  HelloObjc
//
//  Created by jaben on 2020/4/11.
//  Copyright © 2020 Jaben. All rights reserved.
//
//

#import "Employee.h"


NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest;

@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sn;
@property (nullable, nonatomic, retain) Department *department;

@end

NS_ASSUME_NONNULL_END
