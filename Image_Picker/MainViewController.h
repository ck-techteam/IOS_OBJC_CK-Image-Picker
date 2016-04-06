//
//  MainViewController.h
//  Image_Picker
//
//  Created by Armor on 06/04/16.
//  Copyright © 2016 Armor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property(nonatomic,strong)IBOutlet UIImageView * imgView;
@property(nonatomic,strong)IBOutlet UIButton * btnTakePhoto;

-(IBAction)btnTakePhotoTapped:(id)sender;


@end
