//
//  Network.h
//  FoldingTablView
//
//  Created by YXT on 2016/11/28.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Network : NSObject

+ (void)pictypeSuccess:(void(^)(NSArray  *listArray))success failure:(void(^)(id error))failure;

@end
