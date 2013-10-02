//
//  ProjectDetailModel.h
//  BSS
//
//  Created by YANGZQ on 13-9-26.
//  Copyright (c) 2013年 TGNET. All rights reserved.
//

#import "JSONModel.h"

@interface ProjectDetailModel : JSONModel
@property (nonatomic,strong) NSString *is_permission;
@property (nonatomic,strong) NSString *remainder_view_count;
@property (nonatomic,strong) NSString *is_fav;
@property (nonatomic,strong) NSString *projid;                  //id 这里要作处理
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *region;
@property (nonatomic,strong) NSString *update_time;
@property (nonatomic,strong) NSString *publish_time;
@property (nonatomic,strong) NSString *construction_cycle;
@property (nonatomic,strong) NSString *stage;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *storey;
@property (nonatomic,strong) NSString *building_area;
@property (nonatomic,strong) NSString *floor_area;
@property (nonatomic,strong) NSString *construction_cost;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *description;
@property (nonatomic,strong) NSArray *contsModelArray;           //联系人 这里应该是一个对象模型，而且还是一个数组

@property (nonatomic,strong) NSString *movements;
@property (nonatomic,strong) NSString *is_new;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *date;

@end


/*
 "is_permission:是否包含需要查看权限的项目详细数据；
 remainder_view_count：剩余查看次数
 is_fav:是否已经收藏；
 id：项目编号；
 name：项目名；
 region：地区；
 update_time：更新时间；
 publish_time：发布时间；
 construction_cycle：建设周期；
 stage：项目阶段；
 type：项目类别；
 storey：建筑层数；
 building_area：建筑面积；
 floor_area：占地面积；
 construction_cost：工程估价；
 address：项目地址；
 description：项目简介；
    conts：联系人，
 

 movements：项目动态，会员没权限的情况（permission =0）下，为null
 is_new：是否是上次退出到此次登录之间的新动态，（不明白用于做什么）
 content：动态内容；
 date：发布时间
 */