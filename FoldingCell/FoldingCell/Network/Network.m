//
//  Network.m
//  FoldingTablView
//
//  Created by YXT on 2016/11/28.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "Network.h"

@implementation Network

//分类方法
+ (void)pictypeSuccess:(void (^)(NSArray *))success failure:(void (^)(id))failure{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://apis.baidu.com/showapi_open_bus/pic/pic_type"]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"0aa152565745b6ae172fa739bb88dabd" forHTTPHeaderField:@"apikey"];
    
    NSURLSessionConfiguration *configration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configration];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
            return ;
        }
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        NSDictionary *responsedic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *list = [NSArray arrayWithArray:[[responsedic valueForKey:@"showapi_res_body"] valueForKey:@"list"]];
        
        success(list);
    }] resume];
    
    
    
}



@end
