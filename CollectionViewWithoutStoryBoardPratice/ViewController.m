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
    float view_Width_Height_Ratio;
    float buttonCollectionView_height;
    ColorSetting *colorSetting;
    NSTimer *Random_Index_Timer;
    NSInteger Random_Column_Index;
    NSInteger Random_Row_Index;
}
@property(nonatomic, strong) UILabel *columnLabel;
@property(nonatomic, strong) UITextField *columnTextField;
@property(nonatomic, strong) UILabel *rowLabel;
@property(nonatomic, strong) UITextField *rowTextField;
@property(nonatomic, strong) UICollectionView *verticalCollectionView;
@property(nonatomic, strong) UICollectionView *buttonCollectionView;
@end

@implementation ViewController

#pragma mark - ViewController

- (void)viewDidLoad {
    colorSetting = [ColorSetting alloc];
    [colorSetting initColorSetting];
    
    [super viewDidLoad];
    //--------------------- Init -----------------
    collectionView_Column_Num = 0;
    collectionView_Row_Num = 0;
    //--------------------- View Init -----------------------
    [self viewInit];
    //--------------------- Constraints set -----------------------
    [self updateConstraints];
}


// 按下時觸發
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 當按下非keyboard時觸發關閉keyboard
    [self.view endEditing:true];
}
#pragma mark - TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    // 如果是 ColumnTextField 或者 RowTextField 判斷是否為正整數
    if(textField == self.columnTextField) {
        if ([self stringIsPositiveInteger:self.columnTextField.text]) {
            collectionView_Column_Num = [self.columnTextField.text intValue];
            collectionView_Cell_Width = self.verticalCollectionView.bounds.size.width / collectionView_Column_Num;
        }
        else
            self.columnTextField.text = [NSString stringWithFormat: @"%ld", (long)collectionView_Column_Num];
    }
    else if(textField == self.rowTextField) {
        if ([self stringIsPositiveInteger:self.rowTextField.text]) {
            collectionView_Row_Num = [self.rowTextField.text intValue];
            collectionView_Cell_Height = self.verticalCollectionView.bounds.size.height / collectionView_Row_Num;
        }
        else
            self.rowTextField.text = [NSString stringWithFormat: @"%ld", (long)collectionView_Row_Num];
    }
    if(collectionView_Column_Num > 0 && collectionView_Row_Num > 0) {
        [self.verticalCollectionView reloadData];
        [self.buttonCollectionView reloadData];
        
        //--------------- Random Timer ----------------
        /**
         * Reset paremeters in random timer and
         * Enable a new Random Timer
         */
        [Random_Index_Timer invalidate];
        [self enableRandomIndexTimer:collectionView_Row_Num columnNumber:collectionView_Column_Num];
    }
}

#pragma mark - CollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(collectionView_Column_Num > 0 && collectionView_Row_Num > 0) {
        if(collectionView == self.verticalCollectionView) {
            // 在每次重畫VerticalCollectionView的時候移除SubViewController
            if([self getHorizentalCollectionViewControllerNumber:self] > collectionView_Row_Num)
                [self clearHorizentalCollectionViewController:self];
            return collectionView_Row_Num;
        }
        else if(collectionView == self.buttonCollectionView) {
            return collectionView_Column_Num;
        }
    }
    return 0;
}
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //--------------------- verticalCollectionView -----------------------
    if (collectionView == self.verticalCollectionView) {
        UICollectionViewCell *Cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"verticalCellIdentifier" forIndexPath:indexPath];
        
        float X_Location = 0;
        float Y_Location = [indexPath row] * collectionView_Cell_Height;
        float X_Size = [collectionView bounds].size.width;
        float Y_Size = collectionView_Cell_Height;
        
        [Cell setFrame:CGRectMake(X_Location, Y_Location, X_Size, Y_Size)];
        
        //--------------------- CollectionView -----------------------
        HorizentalCollectionViewController *horizentalCollectionViewController = [[HorizentalCollectionViewController alloc] init];
        
        horizentalCollectionViewController.Column_Number = collectionView_Column_Num;
        horizentalCollectionViewController.Random_Column_Index = Random_Column_Index;
        horizentalCollectionViewController.Random_Row_Index = Random_Row_Index;
        horizentalCollectionViewController.Row_Index = [indexPath row];
        
        [self addChildViewController:horizentalCollectionViewController];
        [Cell addSubview:horizentalCollectionViewController.view];
        [horizentalCollectionViewController didMoveToParentViewController:self];
        
        //--------------------- Constraint -----------------------
        [horizentalCollectionViewController.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Cell.mas_top);
            make.bottom.equalTo(Cell.mas_bottom);
            make.left.equalTo(Cell.mas_left);
            make.right.equalTo(Cell.mas_right);
        }];
        
        return Cell;
    }
    //--------------------- buttonCollectionView -----------------------
    else if(collectionView == self.buttonCollectionView) {
        UICollectionViewCell *Cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"buttonCellIdentifier" forIndexPath:indexPath];
        
        float X_Size = [self.buttonCollectionView bounds].size.width / collectionView_Column_Num;
        float Y_Size = [self.buttonCollectionView bounds].size.height;
        float X_Location = [indexPath row] * X_Size;
        float Y_Location = 0;
        
        [Cell setFrame:CGRectMake(X_Location, Y_Location, X_Size, Y_Size)];
        
        //--------------------- Click_View -----------------------
        UILabel *Click_View = [[UILabel alloc] initWithFrame:CGRectZero];
        [Click_View setTranslatesAutoresizingMaskIntoConstraints:NO];
        [Click_View setText:@"確定"];
        [Click_View setTextColor:[self getButtonFontColorNow:indexPath]];
        [Click_View setTextAlignment:NSTextAlignmentCenter];
        [Click_View setBackgroundColor:[self getButtonBackgroundColorNow:indexPath]];
        [Click_View setAdjustsFontSizeToFitWidth:YES];
        
        [Cell addSubview: Click_View];
        
        //--------------------- Constraint -----------------------
        [Click_View mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(Cell.mas_top);
            make.bottom.equalTo(Cell.mas_bottom);
            make.left.equalTo(Cell.mas_left);
            make.right.equalTo(Cell.mas_right);
        }];
        return Cell;
    }
    NSLog(@"CollectionView - cellForItemAtIndexPath unexpected error.");
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //--------------------- verticalCollectionView -----------------------
    if(collectionView == self.verticalCollectionView) {
        
    }
    //--------------------- buttonCollectionView -----------------------
    else if(collectionView == self.buttonCollectionView) {
        NSLog(@"按下");
        [[collectionView cellForItemAtIndexPath:indexPath] setBackgroundColor:colorSetting.Button_HighLight_Color];
        if([indexPath row] == Random_Column_Index) {
            // Reset random
            [Random_Index_Timer invalidate];
            [self enableRandomIndexTimer:collectionView_Row_Num columnNumber:collectionView_Column_Num];
            
            [self.verticalCollectionView reloadData];
            [self.buttonCollectionView reloadData];
        }
    }
}
#pragma mark - Constraints
- (void)updateConstraints {
    //--------------------- ColumnTextView -----------------------
    [self.columnLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_topMargin);
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
    //--------------------- verticalCollectionView -----------------------
    [self.verticalCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.buttonCollectionView.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.rowTextField.mas_bottom);
    }];
    //--------------------- ButtonCollectionView -----------------------
    [self.buttonCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_bottom).offset(- buttonCollectionView_height);
    }];
}

#pragma mark - View Initial

- (void) viewInit {
    //--------------------- View -----------------------
    [self.view setBackgroundColor:colorSetting.BackGround_Color];
    
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
    [self.columnTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
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
    [self.rowTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [self.rowTextField setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview: self.rowTextField];
    
    //--------------------- VerticalCollectionView -----------------------
    UICollectionViewFlowLayout *verticalCollectionViewLayout = [[UICollectionViewFlowLayout alloc] init];

    self.verticalCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:verticalCollectionViewLayout];
    [self.verticalCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"verticalCellIdentifier"];
    [self.verticalCollectionView setDelegate:self];
    [self.verticalCollectionView setDataSource:self];
    [self.verticalCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.verticalCollectionView setScrollEnabled:NO];
    [self.verticalCollectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:self.verticalCollectionView];
    
    //--------------------- ButtonCollectionView -----------------------
    UICollectionViewFlowLayout *buttonCollectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.buttonCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:buttonCollectionViewLayout];
    [self.buttonCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"buttonCellIdentifier"];
    [self.buttonCollectionView setDelegate:self];
    [self.buttonCollectionView setDataSource:self];
    [self.buttonCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.buttonCollectionView setScrollEnabled:NO];
    [self.buttonCollectionView setBackgroundColor:[UIColor clearColor]];
    
    buttonCollectionView_height = self.view.bounds.size.height / 10;
    
    [self.view addSubview:self.buttonCollectionView];
}

#pragma mark - Methods

/**
 * 每十秒隨機一個 index 並 reload collectionview 讓畫面出現 'random'
 */
- (void) enableRandomIndexTimer : (NSInteger) Row_Number columnNumber : (NSInteger) Column_Number {
    Random_Column_Index = -1;
    Random_Row_Index = -1;
    NSMutableArray *CollectionView_Size = [[NSMutableArray alloc] init];
    [CollectionView_Size addObject:[NSNumber numberWithInteger:Row_Number]];
    [CollectionView_Size addObject:[NSNumber numberWithInteger:Column_Number]];
    Random_Index_Timer = [NSTimer scheduledTimerWithTimeInterval:10
                                     target:self
                                   selector:@selector(randomIndex:)
                                   userInfo:CollectionView_Size
                                    repeats:YES];
}

- (void) randomIndex : (NSTimer *)sender {
    NSNumber *Row_Number = [sender.userInfo objectAtIndex:0];
    NSInteger Row_Index = arc4random_uniform([Row_Number intValue]);
    NSNumber *Column_Number = [sender.userInfo objectAtIndex:1];
    NSInteger Column_Index = arc4random_uniform([Column_Number intValue]);
    
    Random_Row_Index = Row_Index;
    Random_Column_Index = Column_Index;
    [self.verticalCollectionView reloadData];
    [self.buttonCollectionView reloadData];
}

/**
 * 判斷 button 是否會跟random 在同個column
 * 如果相同則回傳 highlight color
 * 否則回傳原色
 */
- (UIColor *) getButtonBackgroundColorNow : (NSIndexPath *)indexPath {
    if(Random_Column_Index == [indexPath row]) {
        return colorSetting.Button_HighLight_Color;
    }
    else {
        return colorSetting.Button_Color;
    }
}

/**
 * 判斷 button 是否會跟random 在同個column
 * 如果相同則回傳 highlight text color
 * 否則回傳原色
 */
- (UIColor *) getButtonFontColorNow : (NSIndexPath *)indexPath {
    if(Random_Column_Index == [indexPath row]) {
        return colorSetting.Button_Font_HighLight_Color;
    }
    else {
        return colorSetting.Button_Font_Color;
    }
}

/**
 * 移除 viewcontroller 中屬於 HorizentalCollectionViewController 的 SubViewController
 */
- (void) clearHorizentalCollectionViewController : (UIViewController *) viewController {
    for(int i = 0; i < viewController.childViewControllers.count; i++) {
        if([viewController.childViewControllers objectAtIndex:i].class == HorizentalCollectionViewController.class) {
            HorizentalCollectionViewController *horizentalCollectionViewController = [viewController.childViewControllers objectAtIndex:i];
            [horizentalCollectionViewController willMoveToParentViewController: nil];
            [horizentalCollectionViewController.view removeFromSuperview];
            [horizentalCollectionViewController removeFromParentViewController];
            i = i - 1;
        }
    }
}

/**
 * 取得 ViewController SubViewController 中屬於 HorizentalCollectionViewController 的數量
 */
- (NSInteger) getHorizentalCollectionViewControllerNumber : (UIViewController * ) viewController {
    NSInteger Same_Class_Count = 0;
    for(int i = 0; i < viewController.childViewControllers.count; i++) {
        if ([viewController.childViewControllers objectAtIndex:i].class == HorizentalCollectionViewController.class) {
            Same_Class_Count = Same_Class_Count + 1;
        }
    }
    return Same_Class_Count;
}

- (BOOL) stringIsPositiveInteger : (NSString *) int_String {
    if (int_String.length <= 0 ||
        [int_String rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound) {
        return false;
    }
    else return true;
}
@end
