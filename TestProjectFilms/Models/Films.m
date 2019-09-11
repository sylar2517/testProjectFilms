//
//  Films.m
//  TestProjectFilms
//
//  Created by Сергей Семин on 11/09/2019.
//  Copyright © 2019 Сергей Семин. All rights reserved.
//

#import "Films.h"

@implementation Films

- (instancetype)initWithServerResponse:(NSDictionary*)responseObject
{
    self = [super init];
    if (self) {
        
        NSString* URLString = [responseObject objectForKey:@"image_url"];
        if (URLString && ![URLString isEqual:[NSNull null]]) {
            self.filmImageURL = [NSURL URLWithString:URLString];
        }

        self.filmName = [self checkServerResponse:responseObject forKey:@"name"];
        self.filmLocalizedName = [self checkServerResponse:responseObject forKey:@"localized_name"];
        
        self.filmDescription = [self checkServerResponse:responseObject forKey:@"description"];

        if ([self checkServerResponse:responseObject forKey:@"rating"]) {
            CGFloat rating = [[responseObject objectForKey:@"rating"] doubleValue];
            self.filmRating = [NSString stringWithFormat:@"%1.3f", rating];
        }
        
        if ([self checkServerResponse:responseObject forKey:@"year"]) {
            CGFloat year = [[responseObject objectForKey:@"year"] doubleValue];
            self.filmYear = [NSString stringWithFormat:@"%1.0f", year];
        }
        
    }
    return self;
}


-(id)checkServerResponse:(NSDictionary*)responseObject forKey:(NSString*)key{
    id responce = [responseObject objectForKey:key];
    if (responce) {
        if (![responce isEqual:[NSNull null]]) {
            return responce;
        }
    }
    return nil;
}

@end
