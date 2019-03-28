//
//  BLLMAddress.h
//  BLEBLL
//
//  Created by LiteTrace on 2017/4/24.
//  Copyright © 2017年 LiteTrace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BindSwitchInterface.h"

@interface BLLMAddress : NSObject <BindSwitchInterfaceDelegate>
@property (strong, nonatomic) NSString *mac;
@property (assign, nonatomic) NSUInteger address;

@property (assign, nonatomic) NSUInteger tempAddress;

@property (assign, nonatomic) BOOL shouldChange;

-(instancetype)initWithDict:(NSDictionary *)dict;
-(NSDictionary*)keyValue;
@end

@protocol AAAA <NSObject>

@property (nonatomic,strong) NSString *rrrrrrrr;

@end
