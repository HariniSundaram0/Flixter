//
//  GridViewController.m
//  Pods
//
//  Created by Harini Sundaram on 6/17/22.
//

#import "GridViewController.h"
#import "CollectionViewGridCell.h"
#import "UIImageView+AFNetworking.h"


@interface GridViewController ()<UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *gridView;
@property (nonatomic, strong) NSArray *movies;

@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.gridView.delegate = self;
    self.gridView.dataSource = self;
    [super viewDidLoad];
    [self fetchMoviesGrid];
    
    // Do any additional setup after loading the view.
}
- (void) fetchMoviesGrid {
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
                   
                   self.movies = dataDictionary[@"results"];
                   
                   [self.gridView reloadData];

                   // TODO: Get the array of movies
                   // TODO: Store the movies in a property to use elsewhere
                   // TODO: Reload your table view data
//                   [self.activityIndicator stopAnimating];

               }
//            [self.refreshControl endRefreshing];
           }];
        
        
    //    send task
        [task resume];
    
    
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CollectionViewGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PosterCell" forIndexPath:indexPath];
        NSURL *finalPosterURL = [self ImageURLForIndexPath:indexPath];
//    cell.GridCellPoster = finalPosterURL
    [cell.GridCellPoster setImageWithURL: finalPosterURL] ;
        
        return cell;
}

- (NSURL *)ImageURLForIndexPath: (NSIndexPath *) indexPath{
    NSDictionary *currMovie = self.movies[indexPath.row];
    NSString * baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString * posterURLString = currMovie[@"poster_path"] ;
    NSString * fullPosterURLString = [baseURLString stringByAppendingString : posterURLString ] ;
    NSURL * posterURL = [NSURL URLWithString: fullPosterURLString ] ;
    return posterURL;
//    NSLog(fullPosterURLString);
    
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.movies.count; 
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
                   
                   self.movies = dataDictionary[@"results"];
                   
                   [self.gridView reloadData];
               }
           }];
        
        
    //    send task
        [task resume];
    
    
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
