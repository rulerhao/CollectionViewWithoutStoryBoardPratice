//
//  ColorSettring.h
//  
//
//  Created by louie on 2021/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorSetting : UIViewController
{
    UIColor *BackGround_Color;
    
    UIColor *Button_Color;
    UIColor *Button_HighLight_Color;
    UIColor *Cell_Bottom_Font_Color;
    UIColor *Button_Font_HighLight_Color;
    
    UIColor *Cell_Color1;
    UIColor *Cell_Draw_Color1;
    
    UIColor *Cell_Color2;
    UIColor *Cell_Draw_Color2;

    UIColor *Cell_Color3;
    UIColor *Cell_Draw_Color3;
    
    UIColor *Cell_Bottom_Color;

}
- (void) initColorSetting;
@property (readwrite, nonatomic) UIColor *BackGround_Color;

@property (readwrite, nonatomic) UIColor *Button_Color;
@property (readwrite, nonatomic) UIColor *Button_HighLight_Color;
@property (readwrite, nonatomic) UIColor *Button_Font_Color;
@property (readwrite, nonatomic) UIColor *Button_Font_HighLight_Color;

@property (readwrite, nonatomic) UIColor *Cell_Color1;
@property (readwrite, nonatomic) UIColor *Cell_Draw_Color1;

@property (readwrite, nonatomic) UIColor *Cell_Color2;
@property (readwrite, nonatomic) UIColor *Cell_Draw_Color2;

@property (readwrite, nonatomic) UIColor *Cell_Color3;
@property (readwrite, nonatomic) UIColor *Cell_Draw_Color3;

@property (readwrite, nonatomic) UIColor *Cell_Bottom_Color;

@end

NS_ASSUME_NONNULL_END
