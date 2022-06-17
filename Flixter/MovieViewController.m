//
//  MovieViewController.m
//  Flixter
//
//  Created by Harini Sundaram on 6/15/22.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieViewController () <UITableViewDataSource, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *myArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property NSInteger count;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    [self fetchMovies];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:self.refreshControl];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
  

    // Stop the activity indicator
    // Hides automatically if "Hides When Stopped" is enabled
    // Start the activity indicator
    
}
- (void) fetchMovies {
    //    create url
        NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=2ac19a52f18238daaea1e4c7a1069f3d"];
        
    //    create request
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
        
    //    create session
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
         
    //create task
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               if (error != nil) {
//                   NSLog(@"%@", [error localizedDescription]);
                   UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Network Error"
                                                  message:@"Ah shoot! Please check your wifi >:("
                                                  preferredStyle:UIAlertControllerStyleAlert];
                    
                   UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                      handler:^(UIAlertAction * action) {}];
                    
                   [alert addAction:defaultAction];
                   [self presentViewController:alert animated:YES completion:nil];
               }
               else {
                   NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                   NSLog(@"%@", dataDictionary);// log an object with the %@ formatter.
                   
                   self.myArray = dataDictionary[@"results"];
                   
                   [self.tableView reloadData];

                   // TODO: Get the array of movies
                   // TODO: Store the movies in a property to use elsewhere
                   // TODO: Reload your table view data
                   [self.activityIndicator stopAnimating];

               }
            [self.refreshControl endRefreshing];
           }];
        
        
    //    send task
        [task resume];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MovieCell"];
    
    NSDictionary *movie = self.myArray[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.Synopsis.text = movie[@"overview"];
    
    NSString * baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString * posterURLString = movie[@"poster_path"] ;
    NSString * fullPosterURLString = [baseURLString stringByAppendingString : posterURLString ] ;
    NSURL * posterURL = [NSURL URLWithString: fullPosterURLString ] ;
//    NSLog(fullPosterURLString);
    cell.PosterView.image = nil; 
    [cell.PosterView setImageWithURL: posterURL ] ;
//    cell.textLabel.text = movie[@"title"];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    
    NSIndexPath * myIndexPath = [self.tableView indexPathForCell:sender];
    NSDictionary *dataToPass = self.myArray[myIndexPath.row];
    DetailsViewController *detailVC = [segue destinationViewController];
    detailVC.detailDict = dataToPass;
    NSLog(@"%@", dataToPass);
    // Pass the selected object to the new view controller.
    
    
}



@end
