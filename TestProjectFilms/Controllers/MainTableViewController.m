//
//  MainTableViewController.m
//  TestProjectFilms
//
//  Created by Сергей Семин on 11/09/2019.
//  Copyright © 2019 Сергей Семин. All rights reserved.
//

#import "MainTableViewController.h"
#import "ServerManager.h"
#import "Films.h"
#import "FilmsCell.h"
#import "Sections.h"
#import "FilmViewController.h"

@interface MainTableViewController ()
@property(strong, nonatomic)NSMutableArray* filmsArray;
@property(strong, nonatomic)NSMutableArray* sectionsArray;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filmsArray = [NSMutableArray array];
    self.sectionsArray = [NSMutableArray array];
    [self getFilmsFromServer];
}
#pragma mark - API
-(void) getFilmsFromServer{
    [[ServerManager sharedManager] getFilmsOnSuccess:^(NSArray * _Nonnull films) {
                                                [self.filmsArray addObjectsFromArray:films];
                                                self.sectionsArray = [self generatedSectionsArray];
                                                [self.tableView reloadData];
                                            } onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
                                                if (error) {
                                                    [self showAllertWithMessege:@"Проверьте соединение"];
                                                }
                                            }];
}
#pragma mark - Methods
-(void)showAllertWithMessege:(NSString*)messege{
    UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"Ошибка" message:messege preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction* aa = [UIAlertAction actionWithTitle:@"Ок" style:(UIAlertActionStyleCancel) handler:nil];
    [ac addAction:aa];
    [self presentViewController:ac animated:YES completion:nil];
}
-(NSMutableArray*)generatedSectionsArray{

    NSMutableArray* sectionsArray = [NSMutableArray array];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"filmYear" ascending:YES];
    [self.filmsArray sortUsingDescriptors:@[sortDescriptor]];
    
    NSString* currentYear = nil;
    for (Films*film  in self.filmsArray) {
        Sections* section = nil;
        if (![currentYear isEqualToString:film.filmYear]) {
            section = [[Sections alloc] init];
            section.name = film.filmYear;
            section.films = [NSMutableArray array];
            currentYear = film.filmYear;
            [sectionsArray addObject:section];
        } else {
            section = [sectionsArray lastObject];
        }
        
        [section.films addObject:film];

    }
    
    for (Sections* section in sectionsArray) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"filmRating" ascending:NO];
        [section.films sortUsingDescriptors:@[sortDescriptor]];
    }

    return sectionsArray;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Sections* secions = [self.sectionsArray objectAtIndex:section];
    return [secions.films count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"filmCell";
    FilmsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    Sections* section = [self.sectionsArray objectAtIndex:indexPath.section];
    Films* film = [section.films objectAtIndex:indexPath.row];
    
    cell.filmNameLabel.text = film.filmName;
    cell.localizedNameLabel.text = film.filmLocalizedName;
    cell.ratingLabel.text = film.filmRating;
    CGFloat rating = [film.filmRating doubleValue];
    
    if (rating >= 7) {
        cell.ratingLabel.textColor = [UIColor colorWithRed:0 green:123.0/255.0 blue:0 alpha:1];
    } else if (rating < 5){
        cell.ratingLabel.textColor = [UIColor colorWithRed:1 green:11.0/255.0 blue:11.0/255.0 alpha:1];
    } else {
        cell.ratingLabel.textColor = [UIColor colorWithRed:95.0/255.0 green:95.0/255.0  blue:95.0/255.0  alpha:1];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Sections* secion = [self.sectionsArray objectAtIndex:section];
    return secion.name;

}
#pragma mark - Table view delegat
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Sections* section = [self.sectionsArray objectAtIndex:indexPath.section];
    Films* film = [section.films objectAtIndex:indexPath.row];
    FilmsCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    FilmViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FilmViewController"];
    vc.film = film;
    vc.ratingColor = cell.ratingLabel.textColor;
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
