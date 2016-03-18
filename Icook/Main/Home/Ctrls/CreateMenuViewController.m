//
//  CreateMenuViewController.m
//  Icook
//
//  Created by Macx on 16/2/23.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "CreateMenuViewController.h"

@interface CreateMenuViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImageView *img;

}
@end

@implementation CreateMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, kScreenWidth, 180)];
    
    img.backgroundColor = [UIColor grayColor];
    
    img.image = [UIImage imageNamed:@"createRecipeCamera"];
    
    [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
    
    img.userInteractionEnabled = YES;
    
    img.contentMode = UIViewContentModeCenter;
    
    img.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
    
    [self.view addSubview:img];
    
    [self createTableView];
}


- (void)createTableView
{
    _tableview = [[CreateMenu alloc] initWithFrame:CGRectMake(0, 205, kScreenWidth, kScreenHeight - 299)];
    
    _tableview.name = _name;
    
    [self.view addSubview:_tableview];
}


//第一张图片点击事件

- (void)click:(UITapGestureRecognizer *)sender
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        
        if (!isCamera) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你的摄像头不可用" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:NULL]];
            
            [self presentViewController:alert animated:YES completion:NULL];
            
            return;
        }
        
        UIImagePickerController *pick = [[UIImagePickerController alloc] init];
        
        pick.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        pick.delegate = self;
        
        pick.allowsEditing = YES;
        
        [self presentViewController:pick animated:YES completion:NULL];

    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        
        pickVC.delegate = self;
        
        pickVC.allowsEditing = YES;
        
        pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        [self presentViewController:pickVC animated:YES completion:NULL];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}


#pragma  mark - UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    
    if ([mediaType  isEqual: @"public.image"]) {
        
        //1.获取到被选择的图片
        UIImage *image = info[UIImagePickerControllerEditedImage];
        
        //2.将其显示在界面上
        img.image = image;
        
        img.contentMode =  UIViewContentModeScaleAspectFill;
        
        //如果照片来自摄像头就保存照片到相册
        
        if (picker.sourceType ==UIImagePickerControllerSourceTypeCamera ) {
            
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)image:(UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    
    NSLog(@"保存成功");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
