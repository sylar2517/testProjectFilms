//
//  FilmsCell.h
//  TestProjectFilms
//
//  Created by Сергей Семин on 11/09/2019.
//  Copyright © 2019 Сергей Семин. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FilmsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *localizedNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *filmNameLabel;



@end

NS_ASSUME_NONNULL_END
