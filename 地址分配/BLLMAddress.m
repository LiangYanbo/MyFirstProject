//
//  BLLMAddress.m
//  BLEBLL
//
//  Created by LiteTrace on 2017/4/24.
//  Copyright © 2017年 LiteTrace. All rights reserved.
//

#import "BLLMAddress.h"

@interface BLLMAddress () <AAAA>
{
    NSString *_name;
}

@end

@implementation BLLMAddress

@synthesize name = _name;
-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _mac = dict[@"mac"];
        _address = [dict[@"address"] unsignedIntegerValue];
    }
    return self;
}

-(NSDictionary *)keyValue
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[NSString stringWithFormat:@"%@",_mac] forKey:@"mac"];
    
    [dict setObject:[NSNumber numberWithUnsignedInteger:_address] forKey:@"address"];
    
    return dict;
}
-(void)bindSwitch:(BLLModel *)swt
{
    NSLog(@"绑定开关了");
}
-(void)setName:(NSString *)name
{
    NSLog(@"Name:%@",name);
}
-(NSString *)name
{
    return @"哈哈";
}
@end
