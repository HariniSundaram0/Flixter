//
//  MovieCell.h
//  Flixter
//
//  Created by Harini Sundaram on 6/16/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PosterView;
@property (weak, nonatomic) IBOutlet UILabel *Synopsis;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
