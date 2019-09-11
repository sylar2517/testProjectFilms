//
//  Films.h
//  TestProjectFilms
//
//  Created by Сергей Семин on 11/09/2019.
//  Copyright © 2019 Сергей Семин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface Films : NSObject

@property(strong, nonatomic)NSString* filmName;
@property(strong, nonatomic)NSString* filmLocalizedName;
@property(strong, nonatomic)NSString* filmYear;
@property(assign, nonatomic)NSString* filmRating;
@property(strong, nonatomic)NSURL* filmImageURL;
@property(strong, nonatomic)NSString* filmDescription;


- (instancetype)initWithServerResponse:(NSDictionary*)responseObject;

@end

NS_ASSUME_NONNULL_END
