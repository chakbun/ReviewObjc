//
//  KVOCard.m
//  HelloObjc
//
//  Created by jaben on 2020/5/13.
//  Copyright © 2020 Jaben. All rights reserved.
//

#import "KVOCard.h"

@implementation KVOCard

+ (NSArray *)generateCards:(int)count {
    
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:count];
    
    @autoreleasepool {
            while (count > 0) {
            KVOCard *card = [KVOCard new];
            int random = arc4random()%100+1;
            card.sn = [NSString stringWithFormat:@"%@_%i", @"Apple", random];
            card.date = [NSDate date];
            card.fee = random;
                
                if (random > 80 ) {
                    card.level = @"rich";
                }else if(random > 50) {
                    card.level = @"mid";
                }else if(random > 20) {
                    card.level = @"less";
                }else {
                    card.level = @"poor";
                }
            [temp addObject:card];
            count--;
        }
    }
    
    return temp;

}

@end
