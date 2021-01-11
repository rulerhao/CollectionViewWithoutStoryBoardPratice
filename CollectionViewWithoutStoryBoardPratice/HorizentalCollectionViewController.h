//
//  CollectionViewCell.h
//  CollectionViewWithoutStoryBoardPratice
//
//  Created by louie on 2021/1/6.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "ColorSetting.h"
NS_ASSUME_NONNULL_BEGIN

@interface HorizentalCollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{

}
@property(assign) int16_t Column_Number;
@property(nonatomic) NSInteger Row_Index;

@property(nonatomic) NSInteger Random_Column_Index;
@property(nonatomic) NSInteger Random_Row_Index;

@property(nonatomic, strong) UILabel *TextLabel;
- (void) initView;
@end

NS_ASSUME_NONNULL_END
