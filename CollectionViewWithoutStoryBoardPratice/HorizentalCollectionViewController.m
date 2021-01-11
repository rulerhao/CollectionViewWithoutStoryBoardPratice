//
//  CollectionViewCell.m
//  CollectionViewWithoutStoryBoardPratice
//
//  Created by louie on 2021/1/6.
//

#import "HorizentalCollectionViewController.h"
@interface HorizentalCollectionViewController ()
{
    ColorSetting *colorSetting;
}
@property(nonatomic, strong) UICollectionView *horizentalCollectionView;
@end
@implementation HorizentalCollectionViewController
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    colorSetting = [ColorSetting alloc];
    [colorSetting initColorSetting];
    //--------------------- Initial view -----------------------
    [self viewInit];
    
    //--------------------- Constraints set -----------------------
    [self updateConstraints];
}

#pragma mark - CollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.Column_Number;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    float Cell_Width = [collectionView bounds].size.width / self.Column_Number;
    float Cell_Height = [collectionView bounds].size.height;
    float Cell_X_Axis = Cell_Width * [indexPath row];
    [Cell setFrame:CGRectMake(Cell_X_Axis, 0, Cell_Width, Cell_Height)];
    [Cell setBackgroundColor:[self getCellColorNow:indexPath]];
    
    [self cellViewInitAndConstraint:Cell indexPath:indexPath];
    
    return Cell;
}
#pragma mark - View Initial
- (void) viewInit {
    //--------------------- CollectionView -----------------------
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.horizentalCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.horizentalCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.horizentalCollectionView setDelegate:self];
    [self.horizentalCollectionView setDataSource:self];
    [self.horizentalCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.horizentalCollectionView setScrollEnabled:NO];
    [self.horizentalCollectionView setBackgroundColor:[UIColor clearColor]];

    [self.view addSubview:self.horizentalCollectionView];
}

- (void) cellViewInitAndConstraint : (UICollectionViewCell *) Cell indexPath : (NSIndexPath *) indexPath {
    //--------------------- RandomLabel -----------------------
    UILabel *randomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [randomLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    if(self.Random_Row_Index == self.Row_Index) {
        if(self.Random_Column_Index == [indexPath row]) {
            [randomLabel setText:@"random"];
        }
    }
    [randomLabel setTextAlignment:NSTextAlignmentCenter];
    [randomLabel setAdjustsFontSizeToFitWidth:YES];
    [randomLabel setBackgroundColor:[self selectColor:self.Row_Index]];
    
    [Cell addSubview:randomLabel];
    //--------------------- DrawLabel -----------------------
    UILabel *drawLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [drawLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [drawLabel setTextAlignment:NSTextAlignmentCenter];
    [drawLabel setAdjustsFontSizeToFitWidth:YES];
    [drawLabel setBackgroundColor:[self selectDrawColor:self.Row_Index]];
    
    [Cell addSubview:drawLabel];
    
    //--------------------- BottomSpaceLabel -----------------------
    UILabel *bottomSpaceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [bottomSpaceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [bottomSpaceLabel setTextAlignment:NSTextAlignmentCenter];
    [bottomSpaceLabel setAdjustsFontSizeToFitWidth:YES];
    [bottomSpaceLabel setBackgroundColor:[colorSetting Cell_Bottom_Color]];
    
    [Cell addSubview:bottomSpaceLabel];
    //--------------------- RandomLabel -----------------------
    [randomLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(Cell.mas_right).offset(- [Cell bounds].size.width / 100);
        make.bottom.equalTo(drawLabel.mas_top);
        make.left.equalTo(Cell.mas_left).offset([Cell bounds].size.width / 100);
        make.top.equalTo(Cell.mas_top).offset([Cell bounds].size.height / 100);
    }];
    //--------------------- DrawLabel -----------------------
    [drawLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(Cell.mas_right).offset(- [Cell bounds].size.width / 100);
        make.bottom.equalTo(Cell.mas_bottom);
        make.left.equalTo(Cell.mas_left).offset([Cell bounds].size.width / 100);
        make.top.equalTo(bottomSpaceLabel.mas_top).offset(- [Cell bounds].size.height / 10);
    }];
    //--------------------- BottomSpaceLabel -----------------------
    [bottomSpaceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(Cell.mas_right).offset(- [Cell bounds].size.width / 100);
        make.bottom.equalTo(Cell.mas_bottom);
        make.left.equalTo(Cell.mas_left).offset([Cell bounds].size.width / 100);
        make.top.equalTo(Cell.mas_bottom).offset(- [Cell bounds].size.height / 20);
    }];
}
#pragma mark - Constraints
- (void)updateConstraints {
    //--------------------- CollectionView -----------------------
    [self.horizentalCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
    }];
}

#pragma mark - Methods
/**
 * 判斷 Cell 是否會跟 random 在同個column
 */
- (UIColor *) selectColor : (NSInteger) Row_Index {
    switch (Row_Index % 3) {
        case 0:
            return colorSetting.Cell_Color1;
        case 1:
            return colorSetting.Cell_Color2;
        default:
            return colorSetting.Cell_Color3;
    }
}
/**
 * 判斷 Cell 是否會跟 random 在同個column
 */
- (UIColor *) selectDrawColor : (NSInteger) Row_Index {
    switch (Row_Index % 3) {
        case 0:
            return colorSetting.Cell_Draw_Color1;
        case 1:
            return colorSetting.Cell_Draw_Color2;
        default:
            return colorSetting.Cell_Draw_Color3;
    }
}
/**
 * 判斷 Cell 是否會跟 random 在同個column
 */
- (UIColor *) getCellColorNow : (NSIndexPath *)indexPath {
    if(self.Random_Column_Index == [indexPath row]) {
        return colorSetting.Button_HighLight_Color;
    }
    else {
        return colorSetting.BackGround_Color;
    }
}
@end
