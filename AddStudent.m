//
//  AddStudent.m
//  KUYUTEC
//
//  Created by kuyuZJ on 2017/8/2.
//
//

#import "AddStudent.h"
#import "MStudent.h"
#import "CoreDataManager.h"

@interface AddStudent ()

@property(nonatomic,strong) UITextField* txtUserName;

@property(nonatomic,strong) UITextField* txtSex;

@property(nonatomic,strong) UITextField* txtAge;

@property(nonatomic,strong) UIButton* btnConfirm;

@end

@implementation AddStudent

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.txtUserName];
    [self.view addSubview:self.txtSex];
    [self.view addSubview:self.txtAge];
    [self.view addSubview:self.btnConfirm];
    
    NSArray<NSString*>* formats = @[@"H:|-leftEdge-[txtUserName]-leftEdge-|",@"H:|-leftEdge-[txtSex]-leftEdge-|",
                                    @ "H:|-leftEdge-[txtAge]-leftEdge-|",@"H:|-leftEdge-[btnConfirm]-leftEdge-|",
                                     @"V:|-100-[txtUserName(==44)]-20-[txtSex(txtUserName)]-20-[txtAge(txtUserName)]-20-[btnConfirm(txtUserName)]"];
    NSDictionary<NSString*,id>* metrics = @{ @"defEdge":@(0), @"leftEdge":@(10), @"topEdge":@(10)};
    NSDictionary<NSString*,id>* views = @{ @"txtUserName":self.txtUserName, @"txtSex":self.txtSex, @"txtAge":self.txtAge, @"btnConfirm":self.btnConfirm};
    [formats enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<NSLayoutConstraint*>* constraints = [NSLayoutConstraint constraintsWithVisualFormat:obj options:0 metrics:metrics views:views];
        [self.view addConstraints:constraints];
    }];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch:)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)emptyConfirmTouch:(id)sender{
    MStudent* item = [NSEntityDescription insertNewObjectForEntityForName: @"Student" inManagedObjectContext:[CoreDataManager shareManager].context];
    [item setUserName:self.txtUserName.text];
    [item setSex:@([self.txtSex.text integerValue])];
    [item setSex:@([self.txtAge.text integerValue])];
    
    NSError* error;
    if([[CoreDataManager shareManager].context save:&error]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(IBAction)tapTouch:(id)sender{
    [self.view endEditing:YES];
}


-(UITextField *)txtUserName{
    if(!_txtUserName){
        UITextField* empty = [[UITextField alloc]init];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 88, 44)];
        label.text =  @"用户名";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        empty.leftView = label;
        empty.leftViewMode = UITextFieldViewModeAlways;
        empty.placeholder =  @"请输入用户名";
        empty.translatesAutoresizingMaskIntoConstraints = NO;
        _txtUserName = empty;
    }
    return _txtUserName;
}

-(UITextField *)txtSex{
    if(!_txtSex){
        UITextField* empty = [[UITextField alloc]init];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 88, 44)];
        label.text =  @"性别";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        empty.leftView = label;
        empty.leftViewMode = UITextFieldViewModeAlways;
        empty.placeholder =  @"请输入性别";
        empty.keyboardType = UIKeyboardTypePhonePad;
        empty.translatesAutoresizingMaskIntoConstraints = NO;
        _txtSex = empty;
    }
    return _txtSex;
}



-(UITextField *)txtAge{
    if(!_txtAge){
        UITextField* empty = [[UITextField alloc]init];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 88, 44)];
        label.text =  @"年龄";
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        empty.leftView = label;
        empty.leftViewMode = UITextFieldViewModeAlways;
        empty.placeholder =  @"请输入年龄";
        empty.keyboardType = UIKeyboardTypePhonePad;
        empty.translatesAutoresizingMaskIntoConstraints = NO;
        _txtAge = empty;
    }
    return _txtAge;
}

-(UIButton *)btnConfirm{
    if(!_btnConfirm){
        UIButton* empty = [UIButton buttonWithType:UIButtonTypeCustom];
        [empty setTitle: @"提交" forState:UIControlStateNormal];
        empty.backgroundColor = [UIColor redColor];
        [empty addTarget:self action:@selector(emptyConfirmTouch:) forControlEvents:UIControlEventTouchUpInside];
        empty.translatesAutoresizingMaskIntoConstraints = NO;
        _btnConfirm = empty;
    }
    return _btnConfirm;
}


@end
