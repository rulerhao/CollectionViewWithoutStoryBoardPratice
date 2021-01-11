//
//  ColorSettring.m
//  
//
//  Created by louie on 2021/1/8.
//

#import "ColorSetting.h"

@interface ColorSetting ()

@end

@implementation ColorSetting

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) initColorSetting
{
    //---------------- BackGround Color ----------------
    BackGround_Color = [UIColor colorWithDisplayP3Red:255/255.f green:239/255.f blue:213/255.f alpha:1];
    
    //---------------- Button Color ----------------
    Button_Color = [UIColor colorWithDisplayP3Red:54/255.f green:54/255.f blue:54/255.f alpha:1];
    Button_HighLight_Color = [UIColor colorWithDisplayP3Red:0/255.f green:245/255.f blue:255/255.f alpha:1];
    Button_Font_Color = [UIColor colorWithRed:221/255.f green:221/255.f blue:221/255.f alpha:1];
    Button_Font_HighLight_Color = [UIColor colorWithRed:20/255.f green:20/255.f blue:20/255.f alpha:1];
    
    //---------------- Cell Color ----------------
    /* Cell Color 1 */
    Cell_Color1 = [UIColor colorWithRed:234/255.f green:255/255.f blue:234/255.f alpha:1];
    Cell_Draw_Color1 = [UIColor colorWithDisplayP3Red:10/255.f green:211/255.f blue:10/255.f alpha:1];
    
    /* Cell Color 2 */
    Cell_Color2 = [UIColor colorWithDisplayP3Red:255/255.f green:234/255.f blue:234/255.f alpha:1];
    Cell_Draw_Color2 = [UIColor colorWithDisplayP3Red:211/255.f green:10/255.f blue:10/255.f alpha:1];
    
    /* Cell Color 3 */
    Cell_Color3 = [UIColor colorWithDisplayP3Red:234/255.f green:234/255.f blue:255/255.f alpha:1];
    Cell_Draw_Color3 = [UIColor colorWithDisplayP3Red:10/255.f green:10/255.f blue:211/255.f alpha:1];
    
    //---------------- Cell Bottom Color ----------------
    Cell_Bottom_Color = [UIColor colorWithDisplayP3Red:255/255.f green:255/255.f blue:255/255.f alpha:1];

}
@synthesize BackGround_Color;

@synthesize Button_Color;
@synthesize Button_HighLight_Color;
@synthesize Button_Font_Color;
@synthesize Button_Font_HighLight_Color;

@synthesize Cell_Color1;
@synthesize Cell_Draw_Color1;

@synthesize Cell_Color2;
@synthesize Cell_Draw_Color2;

@synthesize Cell_Color3;
@synthesize Cell_Draw_Color3;

@synthesize Cell_Bottom_Color;

@end
