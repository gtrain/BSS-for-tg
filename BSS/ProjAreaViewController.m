//
//  ProjAreaViewController.m
//  BSS
//
//  Created by zhangbo on 13-9-22.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ProjAreaViewController.h"
#import "Alert.h"
@interface ProjAreaViewController ()

@end

@implementation ProjAreaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationController setHidesBottomBarWhenPushed:YES];
        
        _iProvinceRow=0;
        _iCityRow=17;
        [self getAreaData];
        _arrSelect   =[[NSMutableArray alloc] init];
        _dicProvince =[[NSMutableDictionary alloc] init];
        _arrSelectPro=[[NSMutableArray alloc] init];
        _arrSave     =[[NSMutableArray alloc] init];
    }
    return self;
}

-(void)loadView
{
    //[self getData];
    [super loadView];
    _width=self.view.bounds.size.width;
    _hight=self.view.bounds.size.height;
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self paintProvinceView];
    
    [self paintCityView];
    
    [self.navigationController setHidesBottomBarWhenPushed:YES];
    
}

#pragma mark 绘制省份table
-(void)paintProvinceView
{
    _tbProvince=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, _width-230, _hight-88) style:UITableViewStylePlain];
    _tbProvince.backgroundColor=[UIColor whiteColor];
    _tbProvince.dataSource=self;
    _tbProvince.delegate=self;
    _tbProvince.tag=1;
    
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, _width-230, 44)];
    titleView.layer.borderWidth=0.6;
    titleView.layer.borderColor=[[UIColor alloc] initWithRed:0.00 green:0.20 blue:0.01 alpha:0.1].CGColor;
    titleView.backgroundColor=[[UIColor alloc] initWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, _width-240, 44)];
    lblTitle.backgroundColor=[[UIColor alloc] initWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    lblTitle.text=@"省份";
    lblTitle.font=[UIFont systemFontOfSize:14];
    [titleView addSubview:lblTitle];
    [self.view addSubview:titleView];
    [self.view addSubview:_tbProvince];
}

#pragma mark 绘制城市table
-(void)paintCityView
{
    _tbCity=[[UITableView alloc] initWithFrame:CGRectMake(_width-230, 44, _width-90, _hight-88) style:UITableViewStylePlain];
    _tbCity.backgroundColor=[UIColor whiteColor];
    _tbCity.dataSource=self;
    _tbCity.delegate=self;
    _tbCity.tag=2;
    UIView *titleView=[[UIView alloc] initWithFrame:CGRectMake(_width-230, 0, _width-90, 44)];
    titleView.layer.borderWidth=0.6;
    titleView.layer.borderColor=[[UIColor alloc] initWithRed:0.00 green:0.20 blue:0.01 alpha:0.1].CGColor;
    titleView.backgroundColor=[[UIColor alloc] initWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, _width-90, 44)];
    lblTitle.text=@"城市";
    lblTitle.backgroundColor=[[UIColor alloc] initWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    lblTitle.font=[UIFont systemFontOfSize:14];
    [titleView addSubview:lblTitle];
    [self.view addSubview:titleView];
    [self.view addSubview:_tbCity];
}

#pragma mark 获取地区数据
-(void)getAreaData
{
    [[AFNetEngine shareEngine] opAreaUseCache:NO
                                  onSucceeded:^(NSArray *areaDicArray){
                                      DLog(@"获取到%d个地区资料",areaDicArray.count);
                                      _arrProvince=areaDicArray;
                                      [self getProvinceData];
                                      
                                  } onError:^(RESTError *engineError) {
                                      ELog(engineError);
                                  }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitleAndNavigationBar];
}

#pragma mark 设置标题与返回按钮
-(void)setTitleAndNavigationBar
{
    [self.navigationItem setTitle:@"跟进项目地区"];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(10, 10, 46, 27);
    [btn setBackgroundImage:[UIImage imageNamed:@"button_orange_back"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"button_orange_back_pressed"] forState:UIControlStateHighlighted];
    UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(12, -1, 30, 27)];
    lblTitle.text=@"返回";
    lblTitle.font=[UIFont systemFontOfSize:13];
    lblTitle.textColor=[UIColor whiteColor];
    lblTitle.backgroundColor=[UIColor clearColor];
    [btn addSubview:lblTitle];
    [btn addTarget:self action:@selector(btnPressToBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btnBack=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=btnBack;
    
    UIButton *btnSave=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSave.frame=CGRectMake(10, 10, 46, 27);
    [btnSave setBackgroundImage:[UIImage imageNamed:@"button_orange_square"] forState:UIControlStateNormal];
    [btnSave setBackgroundImage:[UIImage imageNamed:@"button_orange_square_pressed"] forState:UIControlStateHighlighted];
    UILabel *lblSaveTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, -1, 30, 27)];
    lblSaveTitle.text=@"保存";
    lblSaveTitle.font=[UIFont systemFontOfSize:13];
    lblSaveTitle.textColor=[UIColor whiteColor];
    lblSaveTitle.backgroundColor=[UIColor clearColor];
    [btnSave addSubview:lblSaveTitle];
    [btnSave addTarget:self action:@selector(btnPressToSave:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barSave=[[UIBarButtonItem alloc] initWithCustomView:btnSave];
    self.navigationItem.rightBarButtonItem=barSave;
}

#pragma mark 返回事件
-(void)btnPressToBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 提交数据事件
-(void)btnPressToSave:(UIButton *)button
{
    if((_dicProvince==nil||_dicProvince.count==0)&&(_arrSelect==nil||_arrSelect.count==0))
    {
        [Alert show:@"未选择订阅地区"];
        return;
    }
    if(_arrSelectPro.count>0)
    {
        [self deleteSubArea];
    }
    if(_arrSelect!=nil&&_arrSelect.count!=0)
    {
        for (int i=0; i<_arrSelect.count; i++)
        {
            NSString *strNewNo=[self changeAreaNo:[_arrSelect objectAtIndex:i]];
            if(![_arrSave containsObject:strNewNo])
            {
                [_arrSave addObject:strNewNo];
            }
        }
    }
    
    
    
    for (NSEnumerator *key in [_dicProvince keyEnumerator])
    {
        NSMutableArray *arr=[_dicProvince objectForKey:key];
        DLog(@"%@",arr);
        
        for (int i=0; i<[arr count]; i++)
        {
            NSString *strNewNo=[self changeAreaNo:[arr objectAtIndex:i]];
            if(![_arrSave containsObject:strNewNo])
            {
                [_arrSave addObject:strNewNo];
            }
        }
    }
    DLog(@"%@",_arrSave);
    NSString *strSave=[_arrSave componentsJoinedByString:@","];
    DLog(@"%@",strSave);
    [_dicProvince removeAllObjects];
    [_arrSave removeAllObjects];
    [_arrSelect removeAllObjects];
    [_arrSelectPro removeAllObjects];
    [_tbCity reloadData];
    [_tbProvince reloadData];
    [[AFNetEngine shareEngine] opSetSubRegion:strSave onSucceeded:^(NSDictionary *dictionary) {
        DLog(@"设置订阅地区： %@",dictionary);
        [self getProvinceData];
            } onError:^(RESTError *engineError) {
        ELog(engineError);
                [Alert show:engineError.errorDescription];
    }];
}

#pragma mark 获取订阅数据
-(void)getProvinceData
{
    [[AFNetEngine shareEngine] opGetSubInfoOnSucceeded:^(NSDictionary *dictionary)
    {
        DLog(@"获取订阅信息 %@",dictionary);
        [self changeShowAreaNo:dictionary[@"region"]];
        DLog(@"转化后 %@",_dicProvince);
        for (NSArray *arr in _dicProvince) {
            if(arr)
            {
                NSString *str=(NSString *)arr;
                _iProvinceRow=[[str substringFromIndex:2] intValue]-1;
                _iCityRow=[[_arrProvince objectAtIndex:_iProvinceRow][@"subarea"] count]+1;
                break;
            }
        }
        [self setArrSelect];
        [_tbCity reloadData];
        [_tbProvince reloadData];
        [self selectRow];
    } onError:^(RESTError *engineError)
    {
        ELog(engineError);
    }];
}

#pragma mark 获取数据后初始化_arrSelect
-(void)setArrSelect
{
    if(_dicProvince!=nil&&_dicProvince.count>0&&_arrProvince!=nil&&_arrProvince.count>0)
    {
        _arrSelect=[_dicProvince objectForKey:[_arrProvince objectAtIndex:_iProvinceRow][@"no"]];
    } 
}

#pragma mark 获取地区数据1.1.1后转化为10101
-(void)changeShowAreaNo:(NSString *)strAreaNo
{
    NSArray *arr=[strAreaNo componentsSeparatedByString:@","];
    for (NSString *str in arr)
    {
        if(str.length==3||str.length==4)
        {
            if(_arrProvince==nil||_arrProvince.count==0)
            {
                [Alert show:@"无省份数据"];
            }
            for (NSDictionary *dic in _arrProvince)
            {
                if([dic[@"no"] isEqualToString:str])
                {
                    NSString *strNewNo=[self changeCityNo:str];
                    NSMutableArray *arrCity=[[NSMutableArray alloc] init];
                    [_arrSelectPro addObject:[self changeProVinceNo:str]];
                    [arrCity addObject:strNewNo];
                    for (NSDictionary *dicCity in dic[@"subarea"])
                    {
                        [arrCity addObject:[self changeCityNo:dicCity[@"no"]]];
                    }
                    
                    [_dicProvince setObject:arrCity forKey:str];
                    break;
                }
            }
        }
        else
        {
            if([[str substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"."])
            {
                 NSString *strSub=[str substringWithRange:NSMakeRange(0, 3)];
                BOOL bExist=NO;
                for(NSString *key in _dicProvince.keyEnumerator)
                {
                    if([key isEqualToString:strSub])
                    {
                        bExist=YES;
                    }
                }
                if(bExist==YES)
                {
                    //若存在该key,则取出该key得对象存入新字符串
                    NSMutableArray *arr= [_dicProvince objectForKey:strSub];
                    [arr addObject:[self changeCityNo:str]];
                }
                else
                {
                    //若不存在该key,则为新得数组
                    NSMutableArray *arr=[[NSMutableArray alloc] initWithObjects:[self changeCityNo:str], nil];
                    [_dicProvince setObject:arr forKey:strSub];
                }
            }
            else
            {
                NSString *strSub=[str substringWithRange:NSMakeRange(0, 4)];
                BOOL bExist=NO;
                for(NSString *key in _dicProvince.keyEnumerator)
                {
                    if([key isEqualToString:strSub])
                    {
                        bExist=YES;
                    }
                }
                if(bExist==YES)
                {
                    //若存在该key,则取出该key得对象存入新字符串
                    NSMutableArray *arr= [_dicProvince objectForKey:strSub];
                    [arr addObject:[self changeCityNo:str]];
                }
                else
                {
                    //若不存在该key,则为新得数组
                    NSMutableArray *arr=[[NSMutableArray alloc] initWithObjects:[self changeCityNo:str], nil];
                    [_dicProvince setObject:arr forKey:strSub];
                }

            }
        }
    }
}

#pragma mark 修改城市no：1.1.1-》10101
-(NSString *)changeCityNo:(NSString *)strCityNo
{
    return [[strCityNo componentsSeparatedByString:@"."] componentsJoinedByString:@"0"];
}

#pragma mark 修改省份no：1.1-》10100
-(NSString *)changeProVinceNo:(NSString *)strProvinceNo
{
    return [NSString stringWithFormat:@"%@%@",[[strProvinceNo componentsSeparatedByString:@"."] componentsJoinedByString:@"0"],@"00"];
}

#pragma mark 提交数据时相应删除组装处理
-(void)deleteSubArea
{
    if(_arrSelectPro.count!=0)
    {
        for (int i=_arrSelectPro.count-1; i>=0; i--)
        {
            NSString *str=[_arrSelectPro objectAtIndex:i];
            if((_arrSelectPro.count>_dicProvince.count&&[str isEqualToString:[_arrSelectPro objectAtIndex:_arrSelectPro.count-1]])||(_arrSelect!=nil&&_arrSelect.count>0&&[str isEqualToString:[NSString stringWithFormat:@"%@00",[_arrSelect objectAtIndex:0]]]))
            {
                NSString *strSub=[str substringWithRange:NSMakeRange(0, str.length-2)];
                NSString *strSub1=[strSub substringFromIndex:1];
                int i=[strSub1 intValue];
                NSString *strSave=[_arrProvince objectAtIndex:i-1][@"no"];
                if(![_arrSave containsObject:strSave])
                {
                    [_arrSave addObject:strSave];
                }
                [_arrSelectPro removeObject:str];
                [_arrSelect removeAllObjects];
            }
            else
            {
                NSString *strSub=[str substringWithRange:NSMakeRange(0, str.length-2)];
                
                NSString *strSub1=[strSub substringFromIndex:1];
                int i=[strSub1 intValue];
                //            NSDictionary *dicCity = [_arrProvince objectAtIndex:i-1][@"subarea"];
                NSString *strSave=[_arrProvince objectAtIndex:i-1][@"no"];
                if(![_arrSave containsObject:strSave])
                {
                    [_arrSave addObject:strSave];
                }
                [_dicProvince removeObjectForKey:strSave];
                [_arrSelectPro removeObject:str];
            }       
        }
    }
}

#pragma mark 修改地区no：10101-》1.1.1
-(NSString *)changeAreaNo:(NSString *)strAreaNo
{
    NSString *strChangeAreaNo;
    if([[strAreaNo substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"0"])
    {
        if([[strAreaNo substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"0"])
        {
            strChangeAreaNo=[NSString stringWithFormat:@"1.%d.%d",[[strAreaNo substringWithRange:NSMakeRange(1, 3)] intValue],[[strAreaNo substringFromIndex:4] intValue]];
        }
        else
        {
            strChangeAreaNo=[NSString stringWithFormat:@"1.%d.%d",[[strAreaNo substringWithRange:NSMakeRange(1, 2)] intValue],[[strAreaNo substringFromIndex:3] intValue]];
        }
    }
    else
    {
            strChangeAreaNo=[NSString stringWithFormat:@"1.%d.%d",[[strAreaNo substringWithRange:NSMakeRange(1, 3)] intValue],[[strAreaNo substringFromIndex:4] intValue]];
    }
    return strChangeAreaNo;
}

//@required
#pragma mark table行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==1)
    {
        return 34;
    }
    else
    {
        return _iCityRow;
    }
}

#pragma mark 绘制cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    if(tableView.tag==1)
    {
        static NSString *cellID = @"cell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if(cell == nil)
        {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [self processTbProvince:cell indexPath:indexPath];
    }
    else if(tableView.tag==2)
    {
        static NSString *cellID = @"cell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [self processTbCity:cell indexPath:indexPath];
    }
    else
    {
        [Alert show:@"tableView.tag error"];
    }
    
    
    return cell;
}

#pragma mark 用于处理绘制省份cell
-(void)processTbProvince:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[_arrProvince objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"name"];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    cell.textLabel.highlightedTextColor=[UIColor blackColor];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    cell.textLabel.textAlignment=UITextAlignmentCenter;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.opaque=NO;
    if(indexPath.row%2==0)
    {
        UIView *bgV = [[UIView alloc]initWithFrame:cell.contentView.bounds];
        [bgV setBackgroundColor:[UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0]];
        [cell setBackgroundView:bgV];
    }
    else
    {
        UIView *bgV = [[UIView alloc]initWithFrame:cell.contentView.bounds];
        [bgV setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0]];
        [cell setBackgroundView:bgV];
    }
    
    
    
    
    //地区no string转换称数字
    NSArray *arr=nil;
    
    arr=[dic[@"no"] componentsSeparatedByString:@"."];
    NSString *strNewNo=[NSString stringWithFormat:@"%@%@",[arr componentsJoinedByString:@"0"],@"00"];
    if([_arrSelectPro containsObject:strNewNo])
    {
        UIImageView *imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_province_selected"]];
        imgView.frame=CGRectMake(3, 13.5, 15, 15);
        imgView.tag=[strNewNo intValue];
        [cell addSubview: imgView];
    }
    else
    {
        for (NSString *strTag in _arrSelectPro) {
            UIView *view=[cell viewWithTag:[strTag intValue]];
            if([view isKindOfClass:[UIImageView class]])
            {
                [view removeFromSuperview];
            }
        }
    }
    
    cell.layer.borderWidth=0.5;
    
    cell.layer.borderColor=[[UIColor alloc] initWithRed:0.00 green:0.20 blue:0.01 alpha:0.1].CGColor;
    
    UIImageView *bgImgView=[[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    bgImgView.image=[UIImage imageNamed:@"cell_province_selected"];
    [cell setSelectedBackgroundView:bgImgView];
    
}

#pragma mark 用于处理绘制城市cell
-(void)processTbCity:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic=[_arrProvince objectAtIndex:_iProvinceRow];
    if([dic[@"subarea"] count]>=indexPath.row)
    {
        NSDictionary *dicCity=nil;
        if(indexPath.row<1)
        {
            NSString *strTitle =[NSString stringWithFormat:@"%@%@",dic[@"name"],@"所有城市"];
            
            cell.textLabel.text=strTitle;
        }
        else
        {
            dicCity=[dic[@"subarea"] objectAtIndex:indexPath.row-1];
            cell.textLabel.text = dicCity[@"name"];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.accessoryType=UITableViewCellAccessoryNone;
        
        //为cell增加选择框
        UIImageView *imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_city_unselect"] highlightedImage:[UIImage imageNamed:@"button_city_selected"]];
        imgView.frame=CGRectMake(_width-120, 13.5, 15, 15);
        
        //地区no string转换称数字
        NSArray *arr=nil;
        NSString *strNewNo=nil;
        if(indexPath.row<1)
        {
            arr=[dic[@"no"] componentsSeparatedByString:@"."];
        }
        else
        {
            arr=[dicCity[@"no"] componentsSeparatedByString:@"."];
        }
        strNewNo=[arr componentsJoinedByString:@"0"];
        
        //初始化btnSelect 若在dicProvince中存在，则按照原来的形式显示，否则默认不显示
        if([_arrSelect count]==0)
        {
            imgView.highlighted=NO;
        }
        else if([_arrSelect containsObject:strNewNo])
        {
            imgView.highlighted=YES;
        }
        //为btnSelect设置地区标示
        imgView.tag=[strNewNo intValue];
        
        [cell addSubview: imgView];
        //设置cell边框和背景色
        cell.layer.borderWidth=0.5;
        cell.layer.borderColor=[[UIColor alloc] initWithRed:0.00 green:0.20 blue:0.01 alpha:0.1].CGColor;
        cell.backgroundColor = [UIColor clearColor];
        UIView *bgV = [[UIView alloc]initWithFrame:cell.contentView.bounds];
        [bgV setBackgroundColor:[[UIColor alloc] initWithRed:1.0 green:150.0/255.0 blue:0 alpha:1.0]];
        [cell setSelectedBackgroundView:bgV];
    }
}

#pragma mark 选取地区时修改相应的参数
-(void)selectArea:(NSInteger)iTag cell:(UITableViewCell *)cell
{
    NSString *str=[NSString stringWithFormat:@"%d",iTag];
    if(str.length<5)
    {
        NSInteger iRowg=iTag*100;
        NSInteger iRows=iTag*1000;
        
        if([_arrSelect containsObject:[NSString stringWithFormat:@"%d",iTag]])
        {
            [_arrSelect removeObject:[NSString stringWithFormat:@"%d",iTag]];
            [_arrSelectPro removeObject:[NSString stringWithFormat:@"%d%@",iTag,@"00"]];
            
            for (int i=1,iRow=0; i<_iCityRow; i++)
            {
                if(i>=10)
                {
                    iRow=iRows+i;
                }
                else
                {
                    iRow=iRowg+i;
                }
                
                [_arrSelect removeObject:[NSString stringWithFormat:@"%d",iRow]];
                [_tbCity reloadData];
                [_tbProvince reloadData];
                [self selectRow];
            }
        }
        else
        {
            [_arrSelect removeAllObjects];
            [_arrSelect addObject:[NSString stringWithFormat:@"%d",iTag]];
            [_arrSelectPro addObject:[NSString stringWithFormat:@"%d%@",iTag,@"00"]];
            for (int i=1,iRow=0; i<_iCityRow; i++) {
                if(i>=10)
                {
                    iRow=iRows+i;
                }
                else
                {
                    iRow=iRowg+i;
                }
                NSString *strTag=[NSString stringWithFormat:@"%d",iRow];
                if(![_arrSelect containsObject:strTag])
                {
                    [_arrSelect addObject:strTag];
                }
                [_tbCity reloadData];
                [_tbProvince reloadData];
                [self selectRow];
            }
        }
    }
    else
    {
        
        if([_arrSelect containsObject:[NSString stringWithFormat:@"%d",iTag]])
        {
            NSInteger iRow=iTag/100;
            NSString *strNewNo=[NSString stringWithFormat:@"%d%@",iRow,@"00"];
            [_arrSelect removeObject:[NSString stringWithFormat:@"%d",iTag]];
            [_arrSelect removeObject:[NSString stringWithFormat:@"%d",iRow]];
            [_arrSelectPro removeObject:strNewNo];
            [_tbCity reloadData];
            [_tbProvince reloadData];
            [self selectRow];
        }
        else
        {
            NSString *strTag=[NSString stringWithFormat:@"%d",iTag];
            if(![_arrSelect containsObject:strTag])
            {
                [_arrSelect addObject:strTag];
            }
            [_tbCity reloadData];
        }
    }
}

#pragma mark 设置当前选中的省的行数
-(void)selectRow
{
    NSIndexPath *first = [NSIndexPath indexPathForRow:_iProvinceRow inSection:0];
    [_tbProvince selectRowAtIndexPath:first animated:YES scrollPosition:UITableViewScrollPositionTop];

}

//@optional
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==1)
    {
        if(indexPath.row==_iProvinceRow)
        {
            return;
        }
        
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        [cell.textLabel setTextColor:[UIColor blackColor]];
        
        if(_arrSelect.count>0)
        {
            //在转换之前保存原有对象
            NSDictionary *dicLast=[_arrProvince objectAtIndex:_iProvinceRow];
            for (NSString *str in _dicProvince.keyEnumerator) {
                if([str isEqualToString:dicLast[@"no"]])
                {
                    [_dicProvince removeObjectForKey:dicLast[@"no"]];
                    [_dicProvince setObject:_arrSelect forKey:dicLast[@"no"]];
                    break;
                }
            }
            [_dicProvince setObject:_arrSelect forKey:dicLast[@"no"]];
        }
        _arrSelect=nil;
        
        
        //判断是否已经选过的地区 若存在 直接复制给_arrSelect;否则重新初始化
        _iProvinceRow = indexPath.row;
        NSDictionary *dic= [_arrProvince objectAtIndex:_iProvinceRow];
        _iCityRow = [dic[@"subarea"] count]+1;
        if(_dicProvince.count>0)
        {
            for (NSString *str in _dicProvince.keyEnumerator) {
                if([str isEqualToString:dic[@"no"]])
                {
                    _arrSelect=[_dicProvince objectForKey:dic[@"no"]];
                    break;
                }
            }
        }
        if(!_arrSelect)
        {
            _arrSelect=[[NSMutableArray alloc] init];
        }
        [_tbCity reloadData];
    }
    else if(tableView.tag==2)
    {
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        cell.selected=NO;
        
        NSDictionary *dic= [_arrProvince objectAtIndex:_iProvinceRow];
        NSInteger iTag=0;
        if(indexPath.row<1)
        {
            NSString *strNewTag=[[dic[@"no"] componentsSeparatedByString:@"."] componentsJoinedByString:@"0"];
            iTag=[strNewTag intValue];
        }
        else
        {
            NSString *strTag=[dic[@"subarea"] objectAtIndex:indexPath.row-1][@"no"];
            NSString *strNewTag=[[strTag componentsSeparatedByString:@"."] componentsJoinedByString:@"0"];
            iTag=[strNewTag intValue];
        }
        
        
        [self selectArea:iTag cell:cell];
        
    }
    else
    {
        [Alert show:@"tableView.tag error"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
