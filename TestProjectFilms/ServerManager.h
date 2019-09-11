//
//  ServerManager.h
//  TestProjectFilms
//
//  Created by Сергей Семин on 11/09/2019.
//  Copyright © 2019 Сергей Семин. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServerManager : NSObject

+(ServerManager*) sharedManager;

-(void)getFilmsOnSuccess:(void(^)(NSArray* films)) success
               onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

@end

NS_ASSUME_NONNULL_END
