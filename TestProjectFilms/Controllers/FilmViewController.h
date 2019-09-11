//
//  FilmViewController.h
//  TestProjectFilms
//
//  Created by Сергей Семин on 12/09/2019.
//  Copyright © 2019 Сергей Семин. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Films;
@interface FilmViewController : UIViewController


@property(strong, nonatomic)Films* film;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filmNameConstraintHeight;

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *filmNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *filmYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;



@end

NS_ASSUME_NONNULL_END
