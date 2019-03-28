//
//  ViewController.m
//  地址分配
//
//  Created by LiteTrace on 2017/4/26.
//  Copyright © 2017年 LiteTrace. All rights reserved.
//

#import "ViewController.h"
#import "BLLMAddress.h"
#import "BLLModel.h"

@interface ViewController ()

@property (nonatomic,strong) NSMutableArray *outAddresses;
@property (nonatomic,strong) NSMutableArray *inAddresses;
@property (nonatomic,strong) NSMutableArray *tempAddresses;
@property (nonatomic,strong) NSArray *macArr;


@end

@implementation ViewController

-(NSMutableArray *)outAddresses
{
    if (_outAddresses == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _outAddresses = arr;
    }
    
    return _outAddresses;
}

-(NSMutableArray *)inAddresses
{
    if (_inAddresses == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _inAddresses = arr;
    }
    
    return _inAddresses;
}

-(NSMutableArray *)tempAddresses
{
    if (_tempAddresses == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _tempAddresses = arr;
    }
    
    return _tempAddresses;
}

-(NSArray *)macArr
{
    if (_macArr ==nil) {
        NSString *MAC = @"\"3C:2A:53:FF \"E0:78:0C:7C\"49:B9:9B:C3 \"E3:AB:AE:B8\"3A:E4:A9:78 \"AB:9F:D5:6F\"68:1C:A2:09 \"A1:B6:DF:AD\"74:A0:49:DA \"3F:61:D4:4B\"96:5D:79:8C \"D3:0A:CE:B9\"52:0C:15:53 \"51:27:B3:6F\"CB:17:9E:1B \"C1:30:B3:C6\"D0:93:82:53 \"0B:F8:C1:2E\"75:D2:2A:E2 \"4F:7C:E1:AD\"3E:36:B5:0E \"87:F8:69:C9\"96:71:35:7C \"4E:F2:7C:6F\"F4:3F:91:28 \"8A:06:BE:70\"6E:87:19:5C \"49:A5:38:A6\"F3:5C:6D:2B \"9F:A3:FD:B0\"F9:E4:FE:46 \"EF:FE:60:3A\"7D:3F:93:6C \"58:6F:9C:10\"55:B9:0C:7A \"8A:CD:E3:5F\"38:31:22:77 \"2C:47:FC:D5\"96:1A:2A:2B \"D3:1D:02:DF\"6E:1A:C6:66 \"1F:64:E5:55\"DF:80:1A:56 \"0B:23:32:27\"E2:75:72:11 \"D7:4C:D1:24\"4C:37:D2:80 \"2C:D7:21:BD\"E9:F3:36:EB \"06:0F:14:0E\"E7:93:4D:7B \"FD:2A:53:0A\"31:06:65:75 \"D8:63:BA:C1\"D5:48:4E:2E \"A1:16:DA:56\"DF:40:B7:E6 \"0E:25:EA:5F\"24:5E:08:68 \"1B:6A:01:E2\"19:DF:95:30 \"0B:29:0A:AB\"DE:83:5C:65 \"DB:2C:A2:31\"AF:33:DB:1F \"7C:6D:38:D1\"E1:16:69:96 \"C1:C1:CB:06\"E8:85:D1:A4 \"7D:22:86:2A\"60:F6:FD:18 \"9C:75:19:F6\"7E:EC:83:39 \"C5:CC:CE:1C\"6E:84:76:A4 \"F9:D3:01:A7\"5A:71:7B:F7 \"94:FA:03:2B\"E1:11:94:FF \"F3:71:28:1E\"98:DA:AE:5A \"8E:9B:B4:89\"E8:15:91:29 \"56:8E:85:44\"73:67:42:3E \"88:D8:AA:B8\"89:AC:0A:8F \"56:69:3C:0D\"19:C0:E1:2C \"35:AA:D1:99\"94:28:6B:74 \"93:0B:8E:BC\"54:B3:80:58";
        
        
        NSArray *macArr = [MAC componentsSeparatedByString:@"\""];
        _macArr = macArr;
    }
    
    return _macArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    BLLMAddress *newAdd = [[BLLMAddress alloc] init];
    newAdd.name = @"Eric";
    newAdd.address = 1234;
    newAdd.mac = @"AA:BB";
    
    NSLog(@"%@:%@ %d",newAdd.name,newAdd.mac,newAdd.address);
    [newAdd bindSwitch:[[BLLModel alloc] init]];
    
    for (NSInteger i = 1; i<90; i++) {
        BLLMAddress *add = [[BLLMAddress alloc] init];
        add.address = rand()%300+1;
        add.tempAddress = 0;
        add.mac = [self.macArr objectAtIndex:i];
        if (![self isExistOutid:add.address]) {
            [self.outAddresses addObject:add];
        }
        
    }
    
    for (NSInteger i = 1; i<90; i++) {
        BLLMAddress *add = [[BLLMAddress alloc] init];
        add.address = rand()%249+1;
        add.tempAddress = add.address;
        add.mac = [self.macArr objectAtIndex:i];
        if (![self isExistInid:add.address]) {
            [self.inAddresses addObject:add];
        }
        
    }
    
//    [self.outAddresses sortUsingFunction:lampAddressSortAsc context:NULL];
    for (BLLMAddress *add in self.inAddresses) {
        if ([self isFactoryRested:add.mac]) {
            add.shouldChange = NO;
        }
    }
    
//    [self.outAddresses sortUsingFunction:lampAddressSortAsc context:NULL];
//    [self.inAddresses sortUsingFunction:lampAddressSortAsc context:NULL];
    
    for (BLLMAddress *add in self.inAddresses) {
        NSLog(@"oIN:%14@,%6lu,%6lu",add.mac,(unsigned long)add.address,(unsigned long)add.tempAddress);
    }
    NSLog(@"======================================================");
    for (BLLMAddress *add in self.outAddresses) {
        NSLog(@"oOU:%14@,%6lu,%6lu",add.mac,(unsigned long)add.address,(unsigned long)add.tempAddress);
    }
    [self.outAddresses sortUsingFunction:addressSortAsc context:NULL];
    for (BLLMAddress *add in self.outAddresses) {
        if (add.address < 250) {
            if ([self isExistInAddress:add.mac]) {
                //表内有
                BLLMAddress *inAdd = [self getAddress:add.mac];
                if (inAdd.tempAddress == add.address || ![self isExistOutid:inAdd.tempAddress]) {
                    //两个地址相等，或者原来分配地址还没人用,直接使用表内的
                    add.tempAddress = inAdd.tempAddress;
                    inAdd.address = add.address;
                    NSLog(@"两个地址相等，或者原来分配地址还没人用,直接使用表内的%@,%lu---->%lu",add.mac,(unsigned long)add.address,add.tempAddress);

                }else if(![self isExistInid:add.address]){
                    //两个地址不相等，有人用了表内的,自己也没人用了，用自己
                    add.tempAddress = add.address;
                    inAdd.tempAddress = add.address;
                    inAdd.address = add.address;
                    NSLog(@"两个地址不相等，有人用了表内的,自己也没人用了，用自己%@,%lu---->%lu",add.mac,(unsigned long)add.address,add.tempAddress);
                    
                }else{
                    //两个地址不相等，有人用了,但是自己的也被用了，用分配的
                    add.tempAddress = [self getNotExistAddress];
                    inAdd.tempAddress =add.tempAddress;
                    inAdd.address = add.address;
                    NSLog(@"两个地址不相等，有人用了,但是自己的也被用了，用分配的%@,%lu---->%lu",add.mac,(unsigned long)add.address,add.tempAddress);
                }
                
            }else {
                //表内没有,直接看自己的有没有被用
                if (![self isExistInid:add.address]) {
                    //表内没有,自己的有没有被用,就直接用
                    add.tempAddress = add.address;
                    BLLMAddress *newAdd = [[BLLMAddress alloc] init];
                    newAdd.mac = add.mac;
                    newAdd.tempAddress = add.address;
                    newAdd.address = add.address;
                    [self.inAddresses addObject:newAdd];
                    NSLog(@"表内没有,直接看自己的有没有被用,自己也没人用了，用自己%@,%lu---->%lu",add.mac,(unsigned long)add.address,add.tempAddress);
                } else {
                    //表内没有,自己的被用,创建新的
                    BLLMAddress *newAdd = [[BLLMAddress alloc] init];
                    newAdd.mac = add.mac;
                    newAdd.address = add.address;
                    newAdd.tempAddress = [self getNotExistAddress];
                    add.tempAddress = newAdd.tempAddress;
                    [self.inAddresses addObject:newAdd];
                    NSLog(@"表内没有,自己的被用,创建新的%@,%lu---->%lu",add.mac,(unsigned long)add.address,add.tempAddress);
                }
                
            }
        }else{
            //大于250
                BLLMAddress *inAdd = [self getAddress:add.mac];
            if ([self isExistInAddress:add.mac]&& ![self isExistOutid:inAdd.address]) {
                //大于250，表内有,且表内的没被用，直接用表内
                inAdd.address = add.address;
                add.tempAddress = inAdd.tempAddress;
                
                NSLog(@"大于250，表内有,且表内的没被用，直接用表内 %@,%lu---->%lu",add.mac,(unsigned long)add.address,add.tempAddress);
            } else if([self isExistOutid:inAdd.address]){
                
                //大于250，表内有,且表内的被用，创建新的
                inAdd.address = add.address;
                inAdd.tempAddress = [self getNotExistAddress];
                add.tempAddress = inAdd.tempAddress;
                
                NSLog(@"大于250，表内有,且表内的被用，用新的 %@,%lu---->%lu",add.mac,(unsigned long)add.address,add.tempAddress);
            }else{
                //大于250，表内没有有,创建新的
                BLLMAddress *newAdd = [[BLLMAddress alloc] init];
                newAdd.mac = add.mac;
                newAdd.address = add.address;
                newAdd.tempAddress = [self getNotExistAddress];
                add.tempAddress = newAdd.tempAddress;
                [self.inAddresses addObject:newAdd];
                 NSLog(@"大于250，表内没有有,创建新的 %@,%lu---->%lu",add.mac,(unsigned long)add.address,add.tempAddress);
            }
            
        }
    }
    
    
    [self.outAddresses sortUsingFunction:addressSortAsc context:NULL];
    [self.inAddresses sortUsingFunction:addressSortAsc context:NULL];
    
    for (BLLMAddress *add in self.inAddresses) {
        NSLog(@"IN:%14@,%6lu,%6lu",add.mac,(unsigned long)add.address,(unsigned long)add.tempAddress);
    }
    NSLog(@"======================================================");
    for (BLLMAddress *add in self.outAddresses) {
        NSLog(@"OU:%14@,%6lu,%6lu",add.mac,(unsigned long)add.address,(unsigned long)add.tempAddress);
    }
    
}

-(BLLMAddress*)getAddress:(NSString*)mac
{
    for (BLLMAddress *add in self.inAddresses) {
        if ([add.mac isEqualToString:mac]) {
            return add;
        }
    }
    
    return nil;
}

-(BOOL) isExistInAddress:(NSString*)mac
{
    BOOL isExist = NO;
    for (BLLMAddress *add in self.inAddresses) {
        if ([mac isEqualToString:add.mac]) {
            isExist = YES;
        }
    }
    
    return isExist;
}

-(BOOL) isFactoryRested:(NSString*)mac
{
    BOOL isFS = NO;
    for (BLLMAddress *add in self.outAddresses) {
        if ([mac isEqualToString:add.mac]) {
            isFS = YES;
        }
    }
    
    return isFS;
}

-(BOOL) isExistInid:(NSUInteger)address
{
    BOOL isExist = NO;
    for (BLLMAddress *add in self.inAddresses) {
        if (address == add.tempAddress) {
            isExist = YES;
        }
    }
    
    return isExist;
}

-(BOOL) isExistOutid:(NSUInteger)address
{
    BOOL isExist = NO;
    for (BLLMAddress *add in self.outAddresses) {
        if (address == add.address) {
            isExist = YES;
        }
    }
    
    return isExist;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
NSInteger addressSortAsc(id obj1, id obj2, void *context)
{
    BLLMAddress *lamp1,*lamp2;
    //类型转换
    lamp1 = (BLLMAddress*)obj1;
    lamp2 = (BLLMAddress*)obj2;
    if (lamp1.address > lamp2.address) {
        return  NSOrderedDescending;
    } else if (lamp1.address == lamp2.address)
    {
        return  NSOrderedSame;
    } else if (lamp1.address < lamp2.address)
    {
        return  NSOrderedAscending;
    }
    
    return  NSOrderedSame;
}
-(NSUInteger) getNotExistAddress{
    NSInteger newAdd = 0;
    BOOL isExist = YES;
    
    while (isExist == YES) {
        isExist = NO;
        newAdd = newAdd+1;
        isExist = [self isExistInid:newAdd];
        if ([self isExistInid:newAdd]) {
            isExist =YES;
        }
        if ([self isExistOutid:newAdd]) {
            isExist = YES;
        }
    }
    
    if (newAdd >250) {
        NSLog(@"分配地址失败");
        return 0;
    }else {
        return newAdd;
    }
}

-(void)text{
    {
        //                //1.2 先为地址小于250，且还没分配过的灯分配地址
        //                for (BLLMLamp *lamp in theSelf.addingLamps) {
        //                    if (lamp.adress <= 250) {
        //                        //判断地址小于250，
        //
        //                        if ([theSelf isExistMAC:lamp.u_Mac]) {
        //                            //分配过
        //                            if (lamp.adress == [theSelf getNewAddressWithMac:lamp.u_Mac]) {
        //                                //小于250,分配过,且相等，直接用
        //                                lamp.addingAddress = lamp.adress;
        //                                NSLog(@"小于250,分配过,且相等，直接用：%@===%d===>%d",lamp.u_Mac,lamp.adress,lamp.addingAddress);
        //                            } else {
        //                                //小于250,分配过,不相等，也直接用，但是用之前用过这个地址的记录先删掉,
        //
        //                                if ([theSelf isExistAddress:lamp.adress]) {
        //                                    //小于250,分配过,不相等，被其他灯用了，必须要改地址，根据之前的分配来改
        //                                    lamp.addingAddress = [theSelf getNewAddressWithMac:lamp.u_Mac];
        //                                    NSLog(@"小于250,分配过,不相等，被其他灯用了，必须要改地址，根据之前的分配来改：%@===%d===>%d",lamp.u_Mac,lamp.adress,lamp.addingAddress);
        //
        //                                    //如果已经使用这个地址的灯也被重置了，那么这个灯要分配一个新的地址，不能用原来的地址了
        //                                    BLLMLamp *addLamp = [theSelf getNearbyNewLampWhitMac:lamp.u_Mac];
        //                                    if (addLamp != nil) {
        //                                        //如果这个灯也被重置了，重新给他分配一个地址
        //                                        for (BLLMAddress *addres in localAddresses) {
        //                                            if (addres.address == lamp.adress) {
        //                                                NSLog(@"如果已经使用这个地址的灯也被重置了，那么这个灯要分配一个新的地址，不能用原来的地址了：%@===%d",addres.mac,addres.address);
        //                                                addres.address = [theSelf getNewAddresWithbllMAddresses];
        //                                                NSLog(@"如果已经使用这个地址的灯也被重置了，那么这个灯要分配一个新的地址，不能用原来的地址了：%@===%d",addres.mac,addres.address);
        //                                                break;
        //                                            }
        //                                        }
        //                                    }
        //
        //
        //                                } else{
        //                                    //小于250,分配过,也没人用，必须要改地址，根据之前的分配来改
        //                                    lamp.addingAddress = [theSelf getNewAddressWithMac:lamp.u_Mac];
        //                                     NSLog(@"小于250,分配过,也没人用，必须要改地址，根据之前的分配来改：%@===%d===>%d",lamp.u_Mac,lamp.adress,lamp.addingAddress);
        //                                }
        //                            }
        //                        } else {
        //                            //小于250,没分配过,判断一下这个地址是否被用了,没被用，直接用，被用了，修改自己的地址，或者修改已用这个灯的地址
        //
        //                            if ([theSelf isExistAddress:lamp.adress]) {
        //                                //小于250,没分配过,但被其他灯用了，被用了，修改自己的地址，或者修改已用这个灯的地址，那就判断一下这个灯是不是也被重置了
        //
        //                                BLLMLamp *addLamp = [theSelf getNearbyNewLampWhitMac:lamp.u_Mac];
        //                                if (addLamp != nil) {
        //                                    //这个灯被重置或者重置了，自己的地址不改，改被重置的那个灯的地址
        //                                    BLLMAddress *address = [[BLLMAddress alloc] init];
        //                                    address.mac = lamp.u_Mac;
        //                                    address.address = lamp.adress;
        //
        //                                    //加入本地
        //                                    [localAddresses addObject:address];
        //                                    lamp.addingAddress = lamp.adress;
        //                                    NSLog(@"这个灯被重置或者重置了，自己的地址不改，改被重置的那个灯的地址：%@===%d===>%d",lamp.u_Mac,lamp.adress,lamp.addingAddress);
        //
        //                                    //如果已经使用这个地址的灯也被重置了，那么这个灯要分配一个新的地址，不能用原来的地址了
        //                                    //如果这个灯也被重置了，重新给他分配一个地址
        //                                    for (BLLMAddress *addres in localAddresses) {
        //                                        if (addres.address == lamp.adress) {
        //                                            NSLog(@"如果这个灯也被重置了，重新给他分配一个地址：%@===%d",addres.mac,addres.address);
        //                                            addres.address = [theSelf getNewAddresWithbllMAddresses];
        //                                            NSLog(@"如果这个灯也被重置了，重新给他分配一个地址：%@===%d",addres.mac,addres.address);
        //                                            break;
        //                                        }
        //                                    }
        //
        //                                } else {
        //                                    //这个灯没被重置，修改自己的地址
        //#pragma 这个灯没被重置或者重置了没有上电,不知道怎么改了：目前认为是这个灯没被重置。那么新加的灯要分配新地址
        //                                    lamp.addingAddress = [theSelf getNewAddressWithMac:lamp.u_Mac];
        //                                    NSLog(@"这个灯没被重置或者重置了没有上电,不知道怎么改了：目前认为是这个灯没被重置。那么新加的灯要分配新地址：%@===%d===>%d",lamp.u_Mac,lamp.adress,lamp.addingAddress);
        //
        //                                }
        //
        //                            } else {
        //
        //                                //这个灯被重置或者重置了，自己的地址不改，改被重置的那个灯的地址
        //                                BLLMAddress *address = [[BLLMAddress alloc] init];
        //                                address.mac = lamp.u_Mac;
        //                                address.address = lamp.adress;
        //
        //                                //加入本地
        //                                [localAddresses addObject:address];
        //                                lamp.addingAddress = lamp.adress;
        //                                NSLog(@"这个灯被重置或者重置了，自己的地址不改，改被重置的那个灯的地址：%@===%d===>%d",lamp.u_Mac,lamp.adress,lamp.addingAddress);
        //                            }
        //                        }
        //
        ////                        //判断自身小于250的这个地址是否已经被分配了
        ////                        if ([theSelf isExistAddress:lamp.adress]) {
        ////                            //被分配了，只能另外分配一个地址
        ////                            lamp.addingAddress = [theSelf getNewAddressWithMac:lamp.u_Mac];
        ////                            NSLog(@"地址被占用，分配新地址：%d===>%d",lamp.adress,lamp.addingAddress);
        ////                        } else{
        ////                            //还没被分配，直接用这个地址了
        ////                            BLLMAddress *address = [[BLLMAddress alloc] init];
        ////                            address.mac = lamp.u_Mac;
        ////                            address.address = lamp.adress;
        ////
        ////                            //加入本地
        ////                            [localAddresses addObject:address];
        ////                            
        ////                            lamp.addingAddress = lamp.adress;
        ////                            NSLog(@"地址未被占用，用原地址：%d===>%d",lamp.adress,lamp.addingAddress);
        ////                        }
        //                    }
        //                }
        //                
        //                //1.3 再为地址大于250，或者已经分配过的灯分配地址
        //                for (BLLMLamp *lamp in theSelf.addingLamps) {
        //                    if (lamp.adress > 250) {
        //                        //直接取出或者分配的地址
        //                        lamp.addingAddress = [theSelf getNewAddressWithMac:lamp.u_Mac];
        //                        NSLog(@"分配地址：%@===%d===>%d",lamp.u_Mac,lamp.adress,lamp.addingAddress);
        //                    }
        //                }
        
        
    }
}

@end
