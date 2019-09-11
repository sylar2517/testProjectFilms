//
//  FilmViewController.m
//  TestProjectFilms
//
//  Created by Сергей Семин on 12/09/2019.
//  Copyright © 2019 Сергей Семин. All rights reserved.
//

#import "FilmViewController.h"
#import "Films.h"
@import AFNetworking;

@interface FilmViewController ()

@end

@implementation FilmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.film) {
        [self.navigationItem setTitle:self.film.filmLocalizedName];
        
        self.filmNameLabel.text = self.film.filmName;
        
        self.filmYearLabel.text = [NSString stringWithFormat:@"Год: %@",self.film.filmYear];
        
        if (!self.film.filmDescription) {
            self.descriptionTextView.text = @"Описание отсутствует";
        } else {
            self.descriptionTextView.text = self.film.filmDescription;
        }
        
        if (!self.film.filmRating) {
            self.ratingLabel.text = @"-";
        } else {
            self.ratingLabel.text = self.film.filmRating;
            CGFloat rating = [self.film.filmRating doubleValue];
            if (rating >= 7) {
                self.ratingLabel.textColor = [UIColor colorWithRed:0 green:123.0/255.0 blue:0 alpha:1];
            } else if (rating < 5){
                self.ratingLabel.textColor = [UIColor colorWithRed:1 green:11.0/255.0 blue:11.0/255.0 alpha:1];
            } else {
                self.ratingLabel.textColor = [UIColor colorWithRed:95.0/255.0 green:95.0/255.0  blue:95.0/255.0  alpha:1];
            }
        }
        
        __weak FilmViewController* weakSelf = self;
        if (self.film.filmImageURL) {
            NSURLRequest* request = [NSURLRequest requestWithURL:self.film.filmImageURL];
            [self.posterImageView setImageWithURLRequest:request
                                        placeholderImage:nil
                                                 success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                weakSelf.posterImageView.image = image;
                weakSelf.posterImageView.contentMode = UIViewContentModeScaleToFill;
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                if (error) {
                    [self showAllertWithMessege:@"Часть информации не доступна, попробуйте позже или проверьте соединение"];
                }
            }];
        }
        else {
            [self.posterImageView setImage:[UIImage imageNamed:@"noPoster"]];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLayoutSubviews {
    [self.descriptionTextView setContentOffset:CGPointZero animated:NO];
}

#pragma makr - Methods
-(void)showAllertWithMessege:(NSString*)messege{
    UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"Ошибка" message:messege preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction* aa = [UIAlertAction actionWithTitle:@"Ок" style:(UIAlertActionStyleCancel) handler:nil];
    [ac addAction:aa];
    [self presentViewController:ac animated:YES completion:nil];
}

@end
