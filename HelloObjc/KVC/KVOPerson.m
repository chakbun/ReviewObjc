//
//  KVOPerson.m
//  HelloObjc
//
//  Created by jaben on 2020/5/13.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "KVOPerson.h"

@implementation KVOPerson

+ (instancetype)quickPersonWithName:(NSString *)name age:(int)age {
    KVOPerson *person = [KVOPerson new];
    person.name = name;
    person.age = age;
    
    person.address = [KVOAddress instanceWithLine:@"36th Wall Street" code:156];
    
    person.cards = [NSMutableArray arrayWithArray:[KVOCard generateCards:5]];
    return person;
}

@end
