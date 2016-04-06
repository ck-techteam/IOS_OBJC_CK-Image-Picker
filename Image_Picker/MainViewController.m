//
//  MainViewController.m
//  Image_Picker
//
//  Created by Armor on 06/04/16.
//  Copyright © 2016 Armor. All rights reserved.
//

#import "MainViewController.h"
#import "PECropView.h"
#import "PECropViewController.h"

@interface MainViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,PECropViewControllerDelegate>
{
    UIImage *choosenImage;
    
    UIImagePickerController *pick;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Image Picker";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//Action

-(IBAction)btnTakePhotoTapped:(id)sender
{
    {
        [self.view endEditing:YES];
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles: nil];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [actionSheet addButtonWithTitle:NSLocalizedString(@"Take Photo", nil)];
        }
        
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Photo Library", nil)];
        
        if (choosenImage!=nil)
        {
           // [actionSheet addButtonWithTitle:NSLocalizedString(@"Remove Photo", nil)];
        }
        
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
        
        actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
        
        [actionSheet showFromToolbar:self.navigationController.toolbar];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:NSLocalizedString(@"Photo Library", nil)])
    {
        [self openPhotoAlbum];
    }
    else if ([buttonTitle isEqualToString:NSLocalizedString(@"Take Photo", nil)])
    {
        [self showCamera];
    }
//    else if ([buttonTitle isEqualToString:NSLocalizedString(@"Remove Photo", nil)])
//    {
//       
//    }
}
- (void)showCamera
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        
        controller.delegate = self;
        
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:controller animated:YES completion:NULL];
    }];
    
}

- (void)openPhotoAlbum
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        
        controller.delegate = self;
        
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:controller animated:YES completion:NULL];
    }];
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    choosenImage = info[UIImagePickerControllerOriginalImage];
    
    pick = picker;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        PECropViewController *controller = [[PECropViewController alloc] init];
        
        controller.delegate = self;
        
        controller.image = choosenImage;
        
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
        
        [self presentViewController:navigationController animated:YES completion:NULL];
        
    }];
}

- (void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage transform:(CGAffineTransform)transform cropRect:(CGRect)cropRect
{
    NSLog(@"cropped%@",croppedImage);
    
    choosenImage=croppedImage;
    
    self.imgView.image = choosenImage;
    
    choosenImage = croppedImage;
    
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
    
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
        [self presentViewController:pick animated:YES completion:NULL];
        
    }];
}


@end
