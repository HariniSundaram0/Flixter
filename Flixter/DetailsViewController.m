//
//  DetailsViewController.m
//  Flixter
//
//  Created by Harini Sundaram on 6/16/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"


@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *MovieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *PosterView;
@property (weak, nonatomic) IBOutlet UILabel *Popularity;
@property (weak, nonatomic) IBOutlet UILabel *ReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *VoteAvg;
@property (weak, nonatomic) IBOutlet UILabel *Overview;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MovieTitle.text = self.detailDict[@"title"];
    self.ReleaseDate.text = self.detailDict[@"release_date"];
//    self.VoteAvg.text = self.detailDict[@"vote_average"];
//    self.Popularity.text = self.detailDict[@"popularity"];
    self.Overview.text=self.detailDict[@"overview"];
    
    NSString * baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString * posterURLString = self.detailDict[@"poster_path"] ;
    NSString * fullPosterURLString = [baseURLString stringByAppendingString : posterURLString ] ;
    NSURL * posterURL = [NSURL URLWithString: fullPosterURLString ] ;
//    NSLog(fullPosterURLString);
    self.PosterView.image = nil;
    [self.PosterView setImageWithURL: posterURL ] ;
    
//    self.scrollView.delegate = self
//    self.scrollView.dataSource = self
//    cell.
    // Do any additional setup after loading the view.
}

- (void) fetchMoviePoster {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
