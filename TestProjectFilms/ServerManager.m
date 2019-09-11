//
//  ServerManager.m
//  TestProjectFilms
//
//  Created by Сергей Семин on 11/09/2019.
//  Copyright © 2019 Сергей Семин. All rights reserved.
//

#import "ServerManager.h"
#import "Films.h"
@import AFNetworking;

@interface ServerManager()
@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;
@end

@implementation ServerManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString* URLString = @"https://s3-eu-west-1.amazonaws.com/sequeniatesttask/";
        NSURL* URL = [NSURL URLWithString:URLString];
        AFHTTPSessionManager* sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL];
        self.sessionManager = sessionManager;
    }
    return self;
}

+(ServerManager*) sharedManager{
    static ServerManager* sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ServerManager alloc] init];
    });
    
    return sharedManager;
}

-(void)getFilmsOnSuccess:(void(^)(NSArray* films)) success
                onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    [self.sessionManager GET:@"films.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray* films = [responseObject valueForKey:@"films"];
        NSMutableArray* result = [NSMutableArray array];
        for (NSDictionary* filmDictionary in films) {
            Films* film = [[Films alloc] initWithServerResponse:filmDictionary];
            [result addObject:film];
        }
        
        if (success && result.count > 0) {
            success(result);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error, [(NSHTTPURLResponse *)task.response statusCode]);
        }
    }];
    
}

@end
