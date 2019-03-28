//
//  BindSwitchInterface.h
//  地址分配
//
//  Created by LiteTrace on 2017/8/7.
//  Copyright © 2017年 LiteTrace. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLLModel;
@protocol BindSwitchInterfaceDelegate <NSCoding, NSCopying>

NS_ASSUME_NONNULL_BEGIN
//@optional
@property(nonatomic,strong) NSString *name;
-(void)bindSwitch:(BLLModel*)swt;

@end

NS_ASSUME_NONNULL_END
