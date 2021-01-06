//
//  ViewController.m
//  CollectionViewWithoutStoryBoardPratice
//
//  Created by louie on 2021/1/6.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSUInteger collectionView_Column_Num;
    NSUInteger collectionView_Row_Num;
    float collectionView_Cell_Width;
    float collectionView_Cell_Height;
}
@property(nonatomic, strong) UILabel *columnLabel;
@property(nonatomic, strong) UITextField *columnTextField;
@property(nonatomic, strong) UILabel *rowLabel;
@property(nonatomic, strong) UITextField *rowTextField;
@property(nonatomic, strong) UICollectionView *myCollectionView;
@end

@implementation ViewController

#pragma mark - ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //--------------------- View Init -----------------------
    [self viewInit];
    //--------------------- Constraints set -----------------------
    [self updateConstraints];
//    [self.columnTextField ]
//    [self.view addSubview: self.coulmnTextField];
}

- (void) viewDidAppear:(BOOL)animated {
//    NSLog(@"self.view.width = %f", self.view.bounds.size.width);
//    NSLog(@"self.view.helght = %f", self.view.bounds.size.height);
}

//--------------------- 旋轉前觸發 -----------------------
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"self.view.width = %f", self.view.bounds.size.width);
    NSLog(@"self.view.helght = %f", self.view.bounds.size.height);
    NSLog(@"WidthOfCollectionView.width = %f", [self.myCollectionView bounds].size.width);
    NSLog(@"WidthOfCollectionView.height = %f", [self.myCollectionView bounds].size.height);
}


// 按下時觸發
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    // 當按下非keyboard時觸發關閉keyboard
    [self.view endEditing:true];
}
#pragma mark - TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"BegintxtFiledEdit");
    NSLog(@"self.viewWidth = %f", [self.view bounds].size.width);
    NSLog(@"self.myCollectionViewWidth = %f", [self.myCollectionView bounds].size.width);
    if(textField == self.columnTextField) {
        NSLog(@"It's Same");
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(textField == self.columnTextField) {
        collectionView_Column_Num = [self.columnTextField.text intValue];
        collectionView_Cell_Width = self.myCollectionView.bounds.size.width / collectionView_Column_Num;
    } else if(textField == self.rowTextField) {
        collectionView_Row_Num = [self.rowTextField.text intValue];
        collectionView_Cell_Height = self.myCollectionView.bounds.size.height / collectionView_Row_Num;
    }
    [self.myCollectionView reloadData];
}
#pragma mark - CollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionView_Column_Num * collectionView_Row_Num;
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CollectionViewCell *CVC = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewIdentifier" forIndexPath:indexPath];
//    UICollectionViewCell *cell = [CVC ];
    CollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    NSLog(@"indexPathRow = %ld", (long)[indexPath row]);
    NSLog(@"WidthOfCollectionView.width = %f", [collectionView bounds].size.width);
    NSLog(@"WidthOfCollectionView.height = %f", [collectionView bounds].size.height);
    NSUInteger column_Index = [indexPath row] % collectionView_Column_Num;
    NSUInteger row_Index = [indexPath row] / collectionView_Column_Num;
    NSLog(@"index_In_Row = %lu", (unsigned long)column_Index);
    NSLog(@"indexPathLength = %lu", [indexPath length]);
    float X_Location = column_Index * (collectionView_Cell_Width + 5);
    float Y_Location = row_Index * (collectionView_Cell_Height + 5);
//    float X_Location = column_Index * 15;
//    float Y_Location = row_Index * 15;
//    NSLog(@"X_Location = %f", X_Location);
//    NSLog(@"Y_Location = %f", Y_Location);
    float X_Size = collectionView_Cell_Width;
    float Y_Size = collectionView_Cell_Height;
//    float X_Size = 10;
//    float Y_Size = 10;
    [Cell setFrame:CGRectMake(X_Location, Y_Location, X_Size, Y_Size)];
    [Cell setBackgroundColor:[UIColor blueColor]];
    return Cell;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 50, 50);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(50, 50);
//}

#pragma mark - Constraints
- (void)updateConstraints {
    //--------------------- ColumnTextView -----------------------
    [self.columnLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top);
    }];
    //--------------------- ColumnTextField -----------------------
    [self.columnTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.columnLabel.mas_bottom);
    }];
    //--------------------- RowTextView -----------------------
    [self.rowLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.columnTextField.mas_bottom);
    }];
    //--------------------- RowTextField -----------------------
    [self.rowTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.rowLabel.mas_bottom);
    }];
    //--------------------- CollectionView -----------------------
    [self.myCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.rowTextField.mas_bottom);
    }];
}
#pragma mark - View Initial

- (void) viewInit {
    //--------------------- View -----------------------
    [self.view setBackgroundColor:[UIColor brownColor]];
    
    //--------------------- ColumnTextView -----------------------
    self.columnLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.columnLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.columnLabel setText:@"Column"];
    [self.columnLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview: self.columnLabel];
    
    //--------------------- ColumnTextField -----------------------
    self.columnTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.columnTextField setDelegate:self];
    [self.columnTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.columnTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.columnTextField setText:@"0"];
    [self.columnTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.columnTextField setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview: self.columnTextField];
    
    //--------------------- RowTextView -----------------------
    self.rowLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.rowLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rowLabel setText:@"Row"];
    [self.rowLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview: self.rowLabel];
    
    //--------------------- RowTextField -----------------------
    self.rowTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.rowTextField setDelegate:self];
    [self.rowTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.rowTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rowTextField setText:@"0"];
    [self.rowTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.rowTextField setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview: self.rowTextField];

    //--------------------- CollectionView -----------------------
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.myCollectionView setDelegate:self];
    [self.myCollectionView setDataSource:self];
    [self.myCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.myCollectionView setBackgroundColor:[UIColor redColor]];
    [self.myCollectionView setScrollEnabled:NO];
    [self.view addSubview:self.myCollectionView];
}

@end
