-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-01-18 08:27:20.199

-- tables
-- Table: lcly_
CREATE TABLE lcly_ (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","-1") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除',
    sort int NOT NULL DEFAULT 10 COMMENT '排序，从大到小顺序',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    CONSTRAINT lcly__pk PRIMARY KEY (id)
);

-- Table: lcly_activity
CREATE TABLE lcly_activity (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","-1","2","3") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除,2=售罄,3=过期',
    sort int NOT NULL DEFAULT 10 COMMENT '排序，从大到小顺序',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    user_id int NOT NULL COMMENT '所属用户id',
    activity_type enum("1","2","3") NOT NULL DEFAULT "1" COMMENT '活动类型:1=自发,2=资源,3=活动',
    link_id int NOT NULL DEFAULT 0 COMMENT '链接id:1自发活动为0,1资源为resource_id,2活动为activity_id',
    resource_class_id int NOT NULL COMMENT '资源分类id',
    resource_class_parent_id int NOT NULL COMMENT '顶级资源分类id',
    name varchar(200) NOT NULL COMMENT '资源名称',
    adwords varchar(200) NOT NULL DEFAULT '' COMMENT '广告于',
    online enum("0","1") NOT NULL DEFAULT "1" COMMENT '在线状态:0=下架,1=上架',
    cover_image varchar(100) NOT NULL DEFAULT '' COMMENT '封面图',
    total_begin_time int NOT NULL DEFAULT 0 COMMENT '最早开始时间',
    total_end_time int NOT NULL DEFAULT 0 COMMENT '最晚结束时间',
    total_stock int NOT NULL DEFAULT 0 COMMENT '总数量',
    total_sold int NOT NULL DEFAULT 0 COMMENT '总销售数量',
    contact_qq varchar(100) NOT NULL DEFAULT '' COMMENT '联系qq',
    contact_mobile varchar(100) NOT NULL DEFAULT '' COMMENT '联系手机号',
    share_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '是否分享',
    city_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '显示城市:0=不显示,1=显示',
    from_city_code varchar(8) NOT NULL DEFAULT '' COMMENT '出发城市代码',
    to_city_code varchar(8) NOT NULL DEFAULT '' COMMENT '到达城市代码',
    address varchar(200) NOT NULL DEFAULT "" COMMENT '地址信息',
    map_lat decimal(10,6) NOT NULL DEFAULT 0.0 COMMENT '地图纬度',
    map_lng decimal(10,6) NOT NULL DEFAULT 0.0 COMMENT '地图经度',
    CONSTRAINT lcly_activity_pk PRIMARY KEY (id)
) COMMENT '俱乐部活动项目';

-- Table: lcly_activity_content
CREATE TABLE lcly_activity_content (
    id int NOT NULL AUTO_INCREMENT,
    activity_id int NOT NULL,
    images text NOT NULL COMMENT '资源图片列表,逗号分隔',
    detail text NOT NULL COMMENT '资源详情',
    CONSTRAINT lcly_activity_content_pk PRIMARY KEY (id)
) COMMENT '俱乐部活动项目详情';

-- Table: lcly_activity_info
CREATE TABLE lcly_activity_info (
    id int NOT NULL AUTO_INCREMENT,
    activity_id int NOT NULL,
    view int NOT NULL DEFAULT 0 COMMENT '浏览量',
    favourite int NOT NULL DEFAULT 0 COMMENT '收藏量',
    orders int NOT NULL DEFAULT 0 COMMENT '生成的订单数量',
    sold int NOT NULL DEFAULT 0 COMMENT '售出数量',
    evaluate int NOT NULL DEFAULT 0 COMMENT '评论数量',
    CONSTRAINT lcly_activity_info_pk PRIMARY KEY (id)
) COMMENT '活动信息
';

-- Table: lcly_activity_items
CREATE TABLE lcly_activity_items (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","-1","2") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除,2=售罄',
    sort int NOT NULL DEFAULT 10 COMMENT '排序，从大到小顺序',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    activity_id int NOT NULL,
    begin_time int NOT NULL DEFAULT 0 COMMENT '单条开始时间',
    end_time int NOT NULL DEFAULT 0 COMMENT '单条结束时间',
    stock int NOT NULL DEFAULT 0 COMMENT '库存',
    sold int NOT NULL DEFAULT 0 COMMENT '已销售数量',
    `order` int NOT NULL DEFAULT 0 COMMENT '订单临时锁定数量',
    group_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '是否团购',
    group_people int NOT NULL DEFAULT 0 COMMENT '成团人数',
    group_price decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '团购价格',
    retail_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '零售是否启用:0=不开启,1=开启',
    retail_price decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '零售价格',
    child_open enum("0","1") NOT NULL COMMENT '儿童价格是否启用:0=不开启,1=开启',
    child_price decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '儿童价格',
    share_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '开启分享功能',
    share_money decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '分销抽成金额',
    coin_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '开启旅币代付',
    coin_max_num int NOT NULL DEFAULT 0 COMMENT '旅币代付限制数量 0不限制',
    ship_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '需要运输',
    ship_fee decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '运费',
    resource_group_price decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '资源商团购价格',
    resource_retail_price decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '资源商零售价格',
    resource_child_price decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '资源商儿童价格',
    CONSTRAINT lcly_activity_items_pk PRIMARY KEY (id)
) COMMENT '活动时间价格对应表';

-- Table: lcly_club_order
CREATE TABLE lcly_club_order (
    id int NOT NULL AUTO_INCREMENT,
    club_user_id int NOT NULL COMMENT '所属俱乐部用户id',
    order_id int NOT NULL,
    order_sn varchar(50) NOT NULL COMMENT '订单编号',
    order_type enum("A","B","C","D") NOT NULL DEFAULT "A" COMMENT '订单类型:A=普通用户购买俱乐部自发商品,B=普通用户购买俱乐部分享的俱乐部活动,C=普通用户购买俱乐部分享的资源商资源,D=俱乐部直接购买资源商产品',
    order_status enum("0","20","30","40") NOT NULL DEFAULT "20" COMMENT '订单状态:20=完成支付,30=已发货,40=订单完成,0=订单取消',
    resource_class_id int NOT NULL DEFAULT 0 COMMENT '资源分类id',
    resource_class_parent_id int NOT NULL DEFAULT 0 COMMENT '资源分类主id',
    resource_id int NOT NULL DEFAULT 0 COMMENT '资源id,非资源设置0',
    resource_user_id int NOT NULL DEFAULT 0 COMMENT '资源用户id,非资源设置0',
    activity_id int NOT NULL DEFAULT 0 COMMENT '活动id',
    activity_user_id int NOT NULL DEFAULT 0 COMMENT '活动用户id',
    buyer_user_id int NOT NULL DEFAULT 0 COMMENT '用户id',
    begin_time int NOT NULL DEFAULT 0 COMMENT '项目开始时间',
    end_time int NOT NULL DEFAULT 0 COMMENT '项目结束时间',
    numbers int NOT NULL DEFAULT 1 COMMENT '购买数量',
    price_total decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '订单总金额',
    price_money decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '现金支付',
    coin_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '是否可使用旅币抵扣',
    price_coin int NOT NULL DEFAULT 0 COMMENT '旅币使用个数',
    price_coin_precent decimal(8,4) NOT NULL DEFAULT 1 COMMENT '旅币兑换比例',
    price_coin_value decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '旅币抵扣金额',
    order_create_time int NOT NULL DEFAULT 0 COMMENT '订单创建时间',
    order_paid_time int NOT NULL DEFAULT 0 COMMENT '订单支付时间',
    payment_code varchar(100) NOT NULL COMMENT '支付代码',
    payment_fee_precent decimal(8,4) NOT NULL COMMENT '手续费百分比数',
    payment_fee_min decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '最低手续费金额',
    pay_sn varchar(100) NOT NULL DEFAULT '' COMMENT '支付单号',
    pay_tranaction_id varchar(100) NOT NULL DEFAULT '' COMMENT '支付成功返回的支付单号',
    ship_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '是否需要快递',
    ship_fee decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '快递费用',
    money_total decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '总共获取金额',
    money_club_activity decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '俱乐部自营商品收入',
    money_resource_share decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '自营分享收入金额',
    money_club_share decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '俱乐部活动分享提成金额',
    money_pay_resource decimal(10,2) NOT NULL DEFAULT -0.00 COMMENT '俱乐部直接购买资源商产品支出金额',
    money_fee decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '收取手续费',
    CONSTRAINT lcly_club_order_pk PRIMARY KEY (id)
) COMMENT '俱乐部订单表';

-- Table: lcly_coin_change_config
CREATE TABLE lcly_coin_change_config (
    id int NOT NULL AUTO_INCREMENT,
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '修改时间',
    coin int NOT NULL DEFAULT 0.00 COMMENT '旅币变动,支出为负值，收入为正值',
    keyword varchar(100) NOT NULL DEFAULT '' COMMENT '触发事件关键字,程序中使用，勿删改',
    text varchar(200) NOT NULL DEFAULT '' COMMENT '变化原因文字说明',
    CONSTRAINT lcly_coin_change_config_pk PRIMARY KEY (id)
) COMMENT '旅币变动配置';

-- Table: lcly_coin_log
CREATE TABLE lcly_coin_log (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL COMMENT '用户id',
    operator_id int NOT NULL DEFAULT 0 COMMENT '操作人员id:0=系统, 管理人员id，普通用户id',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    coin_change_id int NOT NULL,
    coin int NOT NULL DEFAULT 0.00 COMMENT '旅币变动,支出为负值，收入为正值',
    order_id int NOT NULL DEFAULT 0 COMMENT '涉及订单id,可能为0',
    order_text varchar(200) NOT NULL DEFAULT '' COMMENT '文字说明',
    CONSTRAINT lcly_coin_log_pk PRIMARY KEY (id)
) COMMENT '旅币变动日志';

-- Table: lcly_evaluate_log
CREATE TABLE lcly_evaluate_log (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","-1") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    user_id int NOT NULL COMMENT '用户id',
    order_id int NOT NULL,
    resource_class_id int NOT NULL,
    resource_parent_class_id int NOT NULL,
    resource_id int NOT NULL COMMENT '资源id',
    resource_user_id int NOT NULL COMMENT '资源商id',
    activity_id int NOT NULL COMMENT '对应活动id',
    acrivity_user_id int NOT NULL DEFAULT 0 COMMENT '活动发起userid',
    score int NOT NULL DEFAULT 5 COMMENT '评分',
    evaluate varchar(400) NOT NULL DEFAULT '' COMMENT '评价，100字',
    pictures varchar(400) NOT NULL DEFAULT "" COMMENT '上传图片 ',
    anonymous enum("0","1") NOT NULL DEFAULT "1" COMMENT '是否匿名:0=匿名,1=显示用户名',
    CONSTRAINT lcly_evaluate_log_pk PRIMARY KEY (id)
) COMMENT '订单评价表';

-- Table: lcly_experience_change_config
CREATE TABLE lcly_experience_change_config (
    id int NOT NULL AUTO_INCREMENT,
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '修改时间',
    experience int NOT NULL DEFAULT 0.00 COMMENT '旅币变动,支出为负值，收入为正值',
    keyword varchar(100) NOT NULL DEFAULT '' COMMENT '触发事件关键字,程序中使用，勿删改',
    text varchar(200) NOT NULL DEFAULT '' COMMENT '变化原因文字说明',
    CONSTRAINT lcly_experience_change_config_pk PRIMARY KEY (id)
) COMMENT '经验变动配置';

-- Table: lcly_experience_log
CREATE TABLE lcly_experience_log (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL COMMENT '用户id',
    operator_id int NOT NULL DEFAULT 0 COMMENT '操作人员id:0=系统, 管理人员id，普通用户id',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    experience_change_id int NOT NULL,
    experience int NOT NULL DEFAULT 0.00 COMMENT '旅币变动,支出为负值，收入为正值',
    text varchar(200) NOT NULL DEFAULT '' COMMENT '文字说明',
    link_id int NOT NULL DEFAULT 0 COMMENT '相关id',
    CONSTRAINT lcly_experience_log_pk PRIMARY KEY (id)
) COMMENT '用户经验变动日志';

-- Table: lcly_money_log
CREATE TABLE lcly_money_log (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL COMMENT '用户id',
    operator_id int NOT NULL DEFAULT 0 COMMENT '操作人员id:0=系统, 管理人员id，普通用户id',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    money decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '金额变动,支出为负值，收入为正值',
    order_id int NOT NULL DEFAULT 0 COMMENT '涉及订单id,可能为0',
    order_type enum("U","C","S") NOT NULL DEFAULT "U" COMMENT '订单类型:U=普通用户,C=俱乐部订单,S=资源商订单',
    order_text varchar(200) NOT NULL DEFAULT '' COMMENT '文字说明',
    CONSTRAINT lcly_money_log_pk PRIMARY KEY (id)
) COMMENT '金额变动日志';

-- Table: lcly_order
CREATE TABLE lcly_order (
    id int NOT NULL AUTO_INCREMENT,
    buyer_user_id int NOT NULL DEFAULT 0 COMMENT '用户id',
    order_type enum("A","B","C","D") NOT NULL DEFAULT "A" COMMENT '订单类型:A=普通用户购买俱乐部自发商品,B=普通用户购买俱乐部分享的俱乐部活动,C=普通用户购买俱乐部分享的资源商资源,D=俱乐部直接购买资源商产品',
    order_sn varchar(50) NOT NULL COMMENT '订单编号',
    order_status enum("0","10","20","30","40") NOT NULL DEFAULT "10" COMMENT '订单状态:10=等待支付,20=完成支付,30=已发货,40=订单完成,0=订单取消',
    resource_class_id int NOT NULL DEFAULT 0 COMMENT '资源分类id',
    resource_class_parent_id int NOT NULL DEFAULT 0 COMMENT '资源分类主id',
    resource_id int NOT NULL DEFAULT 0 COMMENT '资源id,非资源设置0',
    resource_user_id int NOT NULL DEFAULT 0 COMMENT '资源用户id,非资源设置0',
    activity_id int NOT NULL DEFAULT 0 COMMENT '活动id',
    activity_user_id int NOT NULL DEFAULT 0 COMMENT '活动用户id',
    contact_name varchar(50) NOT NULL DEFAULT '' COMMENT '联系人姓名',
    contact_mobile varchar(20) NOT NULL DEFAULT '' COMMENT '联系人手机号',
    begin_time int NOT NULL DEFAULT 0 COMMENT '项目开始时间',
    end_time int NOT NULL DEFAULT 0 COMMENT '项目结束时间',
    numbers int NOT NULL DEFAULT 1 COMMENT '购买数量',
    available int NOT NULL DEFAULT 0 COMMENT '可用数量',
    writeoff_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '是否核销商品',
    writeoff_nums int NOT NULL DEFAULT 0 COMMENT '核销数量',
    writeoff_once_num int NOT NULL DEFAULT 1 COMMENT '一次核销需要核销数量',
    price_total decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '订单总金额',
    price_money decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '现金支付',
    coin_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '是否可使用旅币抵扣',
    price_coin int NOT NULL DEFAULT 0 COMMENT '旅币使用个数',
    price_coin_precent decimal(8,4) NOT NULL DEFAULT 1 COMMENT '旅币兑换比例',
    price_coin_value decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '旅币抵扣金额',
    order_create_time int NOT NULL DEFAULT 0 COMMENT '订单生成时间',
    order_paid_time int NOT NULL DEFAULT 0 COMMENT '订单支付时间',
    order_ship_time int NOT NULL DEFAULT 0 COMMENT '订单发货时间',
    order_finish_time int NOT NULL DEFAULT 0 COMMENT '订单完成时间',
    order_expired_time int NOT NULL DEFAULT 0 COMMENT '订单未付款过期时间',
    order_cancel_time int NOT NULL DEFAULT 0 COMMENT '订单取消时间',
    payment_code varchar(100) NOT NULL COMMENT '支付代码',
    payment_fee_precent decimal(8,4) NOT NULL COMMENT '手续费百分比数',
    payment_fee_min decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '最低手续费金额',
    pay_sn varchar(100) NOT NULL DEFAULT '' COMMENT '支付单号',
    pay_tranaction_id varchar(100) NOT NULL DEFAULT '' COMMENT '支付成功返回的支付单号',
    user_delete enum("0","1") NOT NULL DEFAULT "0" COMMENT '用户删除标志',
    ship_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '是否需要快递',
    ship_fee decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '快递费用',
    ship_company varchar(100) NOT NULL DEFAULT '' COMMENT '快递公司名称',
    ship_code varchar(100) NOT NULL DEFAULT '' COMMENT '快递公司单号',
    evaluate enum("0","1") NOT NULL DEFAULT "0" COMMENT '是否完成评价',
    CONSTRAINT lcly_order_pk PRIMARY KEY (id)
) COMMENT '订单表';

-- Table: lcly_order_detail
CREATE TABLE lcly_order_detail (
    id int NOT NULL AUTO_INCREMENT,
    order_id int NOT NULL,
    buyer_address_info text NOT NULL COMMENT '联系人地址信息json序列化',
    people_info text NOT NULL COMMENT '人员信息json序列化',
    CONSTRAINT lcly_order_detail_pk PRIMARY KEY (id)
) COMMENT '订单信息表';

-- Table: lcly_order_log
CREATE TABLE lcly_order_log (
    id int NOT NULL AUTO_INCREMENT,
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    order_id int NOT NULL,
    old_status enum("0","10","20","30","40") NOT NULL COMMENT '原订单状态',
    new_status enum("0","10","20","30","40") NOT NULL COMMENT '新订单状态',
    operator_id int NOT NULL DEFAULT 0 COMMENT '操作人员id:0=系统, 管理人员id，普通用户id',
    order_type enum("U","C","S") NOT NULL DEFAULT "U" COMMENT '订单类型:U=普通用户,C=俱乐部订单,S=资源商订单',
    order_text varchar(200) NOT NULL DEFAULT '' COMMENT '文字说明',
    money decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '金额变动,支出为负值，收入为正值',
    coin int NOT NULL DEFAULT 0 COMMENT '旅币变动,支出为负值，收入为正值',
    CONSTRAINT lcly_order_log_pk PRIMARY KEY (id)
) COMMENT '订单日志';

-- Table: lcly_pay
CREATE TABLE lcly_pay (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","2") NOT NULL DEFAULT "1" COMMENT '状态:1=等待付款,0=过期,2=付款完成',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    order_id int NOT NULL,
    pay_sn varchar(100) NOT NULL DEFAULT '' COMMENT '支付单号',
    user_id int NOT NULL COMMENT '用户id',
    name varchar(100) NOT NULL COMMENT '支付方式名称',
    code varchar(100) NOT NULL COMMENT '支付代码',
    pay_money decimal(10,2) NOT NULL,
    transaction_id varchar(100) NOT NULL DEFAULT '' COMMENT '支付成功后返回id',
    pay_data text NOT NULL COMMENT '支付返回所有信息 ',
    CONSTRAINT lcly_pay_pk PRIMARY KEY (id)
) COMMENT '支付方式';

-- Table: lcly_payment
CREATE TABLE lcly_payment (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","-1") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除',
    sort int NOT NULL DEFAULT 10 COMMENT '排序，从大到小顺序',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    name varchar(100) NOT NULL COMMENT '支付方式名称',
    code varchar(100) NOT NULL COMMENT '支付代码',
    fee_precent decimal(8,4) NOT NULL DEFAULT 2 COMMENT '支付手续费百分比',
    fee_min decimal(10,2) NOT NULL DEFAULT 0.01 COMMENT '最低手续费金额',
    UNIQUE INDEX code (code),
    CONSTRAINT lcly_payment_pk PRIMARY KEY (id)
) COMMENT '支付方式';

-- Table: lcly_resource
CREATE TABLE lcly_resource (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","-1","2","3") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除,2=售罄,3=过期',
    sort int NOT NULL DEFAULT 10 COMMENT '排序，从大到小顺序',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    user_id int NOT NULL COMMENT '所属用户id',
    resource_class_id int NOT NULL COMMENT '资源分类id',
    resource_class_parent_id int NOT NULL COMMENT '顶级资源分类id',
    name varchar(200) NOT NULL COMMENT '资源名称',
    adwords varchar(200) NOT NULL DEFAULT '' COMMENT '广告于',
    online enum("0","1") NOT NULL DEFAULT "1" COMMENT '在线状态:0=下架,1=上架',
    cover_image varchar(100) NOT NULL DEFAULT '' COMMENT '封面图',
    total_begin_time int NOT NULL DEFAULT 0 COMMENT '最早开始时间',
    total_end_time int NOT NULL DEFAULT 0 COMMENT '最晚结束时间',
    total_stock int NOT NULL DEFAULT 0 COMMENT '总数量',
    total_sold int NOT NULL DEFAULT 0 COMMENT '总销售数量',
    contact_qq varchar(100) NOT NULL DEFAULT '' COMMENT '联系qq',
    contact_mobile varchar(100) NOT NULL DEFAULT '' COMMENT '联系手机号',
    writeoff enum("1","0") NOT NULL DEFAULT "0" COMMENT '是否可选核销:0=不需要核销,1=需要核销',
    city_open enum("1","0") NOT NULL DEFAULT "0" COMMENT '是否显示城市:0=不显示,1=显示',
    from_city_code varchar(8) NOT NULL DEFAULT "" COMMENT '出发城市代码',
    to_city_code varchar(8) NOT NULL DEFAULT "" COMMENT '到达城市代码',
    address varchar(200) NOT NULL DEFAULT "" COMMENT '地址信息',
    map_lat decimal(10,6) NOT NULL DEFAULT 0.0 COMMENT '地图纬度',
    map_lng decimal(10,6) NOT NULL DEFAULT 0.0 COMMENT '地图经度',
    CONSTRAINT lcly_resource_pk PRIMARY KEY (id)
) COMMENT '资源项目';

-- Table: lcly_resource_class
CREATE TABLE lcly_resource_class (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","-1") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除',
    sort int NOT NULL DEFAULT 10 COMMENT '排序，从大到小顺序',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    name varchar(100) NOT NULL COMMENT '资源分类名称',
    parent_id int NOT NULL DEFAULT 0 COMMENT '上级id',
    menu int NOT NULL DEFAULT 0 COMMENT '网站菜单id',
    CONSTRAINT lcly_resource_class_pk PRIMARY KEY (id)
) COMMENT '资源分类树';

-- Table: lcly_resource_content
CREATE TABLE lcly_resource_content (
    id int NOT NULL AUTO_INCREMENT,
    resource_id int NOT NULL,
    images text NOT NULL COMMENT '资源图片列表,逗号分隔',
    detail text NOT NULL COMMENT '资源详情',
    declaration text NOT NULL COMMENT '特别声明',
    CONSTRAINT lcly_resource_content_pk PRIMARY KEY (id)
) COMMENT '资源项目详情';

-- Table: lcly_resource_info
CREATE TABLE lcly_resource_info (
    id int NOT NULL AUTO_INCREMENT,
    resource_id int NOT NULL,
    view int NOT NULL DEFAULT 0 COMMENT '浏览量',
    favourite int NOT NULL DEFAULT 0 COMMENT '收藏量',
    activity int NOT NULL DEFAULT 0 COMMENT '生成的活动数量',
    orders int NOT NULL DEFAULT 0 COMMENT '订单数量',
    sold int NOT NULL DEFAULT 0 COMMENT '销售数量',
    evaluate int NOT NULL DEFAULT 0 COMMENT '评论数量',
    CONSTRAINT lcly_resource_info_pk PRIMARY KEY (id)
) COMMENT '资源信息
';

-- Table: lcly_resource_items
CREATE TABLE lcly_resource_items (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","-1","2") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除,2=售罄',
    sort int NOT NULL DEFAULT 10 COMMENT '排序，从大到小顺序',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    resource_id int NOT NULL COMMENT '资源id',
    begin_time int NOT NULL DEFAULT 0 COMMENT '单条开始时间',
    end_time int NOT NULL DEFAULT 0 COMMENT '单条结束时间',
    stock int NOT NULL DEFAULT 0 COMMENT '原始库存数量',
    sold int NOT NULL DEFAULT 0 COMMENT '售出数量',
    activity int NOT NULL DEFAULT 0 COMMENT '分享活动锁定数量,临时锁定。活动过期后，恢复',
    group_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '组团是否启用:0=不开启,1=开启',
    group_price decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '组团价',
    group_min_people int NOT NULL DEFAULT 0 COMMENT '组团最少人数',
    retail_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '零售是否启用:0=不开启,1=开启',
    retail_price decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '零售价格',
    price_limit decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '成人限价,0.00为不开启',
    child_open enum("0","1") NOT NULL COMMENT '儿童价格是否启用:0=不开启,1=开启',
    child_price decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '儿童价格',
    child_price_limit decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '儿童价格限价 0.00为不限制',
    CONSTRAINT lcly_resource_items_pk PRIMARY KEY (id)
) COMMENT '资源时间价格对应表';

-- Table: lcly_resource_order
CREATE TABLE lcly_resource_order (
    id int NOT NULL AUTO_INCREMENT,
    resource_user_id int NOT NULL COMMENT '所属俱乐部用户id',
    order_id int NOT NULL,
    order_sn varchar(50) NOT NULL COMMENT '订单编号',
    club_order_id int NOT NULL COMMENT '俱乐部订单id',
    order_type enum("C","D") NOT NULL DEFAULT "C" COMMENT '订单类型:C=普通用户购买俱乐部分享的资源商资源,D=俱乐部直接购买资源商产品',
    order_status enum("0","20","30","40") NOT NULL DEFAULT "20" COMMENT '订单状态:,20=完成支付,30=已发货,40=订单完成,0=订单取消',
    resource_class_id int NOT NULL DEFAULT 0 COMMENT '资源分类id',
    resource_class_parent_id int NOT NULL DEFAULT 0 COMMENT '资源分类主id',
    resource_id int NOT NULL DEFAULT 0 COMMENT '资源id,非资源设置0',
    activity_id int NOT NULL DEFAULT 0 COMMENT '活动id',
    activity_user_id int NOT NULL DEFAULT 0 COMMENT '活动用户id',
    buyer_user_id int NOT NULL DEFAULT 0 COMMENT '用户id',
    begin_time int NOT NULL DEFAULT 0 COMMENT '项目开始时间',
    end_time int NOT NULL DEFAULT 0 COMMENT '项目结束时间',
    numbers int NOT NULL DEFAULT 1 COMMENT '购买数量',
    price_total decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '订单总金额',
    price_money decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '现金支付',
    coin_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '是否可使用旅币抵扣',
    price_coin int NOT NULL DEFAULT 0 COMMENT '旅币使用个数',
    price_coin_precent decimal(8,4) NOT NULL DEFAULT 1 COMMENT '旅币兑换比例',
    price_coin_value decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '旅币抵扣金额',
    order_create_time int NOT NULL DEFAULT 0 COMMENT '订单创建时间',
    order_paid_time int NOT NULL DEFAULT 0 COMMENT '订单支付时间',
    payment_code varchar(100) NOT NULL COMMENT '支付代码',
    payment_fee_precent decimal(8,4) NOT NULL COMMENT '手续费百分比数',
    payment_fee_min decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '最低手续费金额',
    pay_sn varchar(100) NOT NULL DEFAULT '' COMMENT '支付单号',
    pay_tranaction_id varchar(100) NOT NULL DEFAULT '' COMMENT '支付成功返回的支付单号',
    ship_open enum("0","1") NOT NULL DEFAULT "0" COMMENT '是否需要快递',
    ship_fee decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '快递费用',
    money_total decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '总共获取金额',
    money_fee decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '收取手续费',
    CONSTRAINT lcly_resource_order_pk PRIMARY KEY (id)
) COMMENT '资源商订单表';

-- Table: lcly_resource_writeoff
CREATE TABLE lcly_resource_writeoff (
    id int NOT NULL AUTO_INCREMENT,
    resource_id int NOT NULL,
    writeoff_user_id int NOT NULL COMMENT '绑定核销用户id',
    CONSTRAINT lcly_resource_writeoff_pk PRIMARY KEY (id)
) COMMENT '资源核销信息
';

-- Table: lcly_user
CREATE TABLE lcly_user (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","-1") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除',
    sort int NOT NULL DEFAULT 10 COMMENT '排序，从大到小顺序',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    username varchar(200) NOT NULL COMMENT '用户名',
    password varchar(50) NOT NULL COMMENT '密码 算法:md5(输入密码+salt)',
    salt varchar(20) NOT NULL DEFAULT '' COMMENT '自动生成密码随机数，可为空',
    mobile varchar(20) NOT NULL COMMENT '手机号码,必填',
    email varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱',
    wx_openid varchar(60) NOT NULL DEFAULT '' COMMENT '微信openid',
    qq_openid varchar(60) NOT NULL DEFAULT '' COMMENT 'QQ openid',
    user_type enum("10","20","30") NOT NULL DEFAULT "10" COMMENT '用户类型:10=普通会员,20=俱乐部,30=资源商',
    reg_ip varchar(50) NOT NULL DEFAULT '' COMMENT '注册时ip地址',
    recommend_user_id int NOT NULL DEFAULT 0 COMMENT '推荐人',
    CONSTRAINT lcly_user_pk PRIMARY KEY (id)
) COMMENT '用户表';

-- Table: lcly_user_club
CREATE TABLE lcly_user_club (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    club_name varchar(100) NOT NULL DEFAULT '' COMMENT '俱乐部名称',
    idcard_image varchar(100) NOT NULL DEFAULT '' COMMENT '身份证照片',
    club_mobile varchar(100) NOT NULL DEFAULT '' COMMENT '俱乐部电话',
    club_address varchar(100) NOT NULL DEFAULT '' COMMENT '俱乐部地址',
    club_logo varchar(100) NOT NULL DEFAULT '' COMMENT 'logo',
    begin_time int NOT NULL DEFAULT 0 COMMENT '审核通过时间',
    CONSTRAINT lcly_user_club_pk PRIMARY KEY (id)
) COMMENT '俱乐部会员信息';

-- Table: lcly_user_group
CREATE TABLE lcly_user_group (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","-1") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除',
    sort int NOT NULL DEFAULT 10 COMMENT '排序，从大到小顺序',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    group_name varchar(100) NOT NULL COMMENT '用户等级信息',
    min_experience int NOT NULL COMMENT '最少经验数量',
    CONSTRAINT lcly_user_group_pk PRIMARY KEY (id)
) COMMENT '用户等级表';

-- Table: lcly_user_resource
CREATE TABLE lcly_user_resource (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    company_name varchar(100) NOT NULL DEFAULT '' COMMENT '公司名称',
    idcard_image varchar(100) NOT NULL DEFAULT '' COMMENT '身份证照片',
    company_image varchar(100) NOT NULL DEFAULT '' COMMENT '营业执照照片',
    agreement_image varchar(100) NOT NULL DEFAULT '' COMMENT '合同照片',
    company_mobile varchar(100) NOT NULL DEFAULT '' COMMENT '公司电话',
    company_address varchar(100) NOT NULL DEFAULT '' COMMENT '公司地址',
    company_logo varchar(100) NOT NULL DEFAULT '' COMMENT 'logo',
    begin_time int NOT NULL DEFAULT 0 COMMENT '开始使用时间',
    CONSTRAINT lcly_user_resource_pk PRIMARY KEY (id)
) COMMENT '资源会员信息';

-- Table: lcly_user_resource_writeoff_user
CREATE TABLE lcly_user_resource_writeoff_user (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    status enum("1","0","9") NOT NULL DEFAULT "1" COMMENT '核销会员状态:1=等待审核,9=审核通过,0=审核未通过',
    writeoff_user_id int NOT NULL COMMENT '核销会员id',
    writeoff_createtime int NOT NULL DEFAULT 0 COMMENT '创建时间',
    writeoff_verifytime int NOT NULL DEFAULT 0 COMMENT '通过不通过时间',
    writeoff_user_mobile varchar(50) NOT NULL DEFAULT '' COMMENT '核销会员手机号',
    writeoff_user_name varchar(50) NOT NULL DEFAULT '' COMMENT '核销会员姓名',
    demo varchar(200) NOT NULL COMMENT '备注信息',
    signup_info varchar(200) NOT NULL DEFAULT "" COMMENT '提交核销资格信息',
    CONSTRAINT lcly_user_resource_writeoff_user_pk PRIMARY KEY (id)
) COMMENT '资源核销会员信息';

-- Table: lcly_user_signup
CREATE TABLE lcly_user_signup (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    status enum("1","0","-1") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除',
    sort int NOT NULL DEFAULT 10 COMMENT '排序，从大到小顺序',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    user_type_signup enum("-1","0","20","30") NOT NULL DEFAULT "0" COMMENT '用户类型:-1=审核失败,0=未申请,20=俱乐部申请中,30=资源商申请中',
    signup_name varchar(100) NOT NULL DEFAULT '' COMMENT '申请名',
    idcard_image varchar(100) NOT NULL DEFAULT '' COMMENT '身份证照片',
    company_image varchar(100) NOT NULL DEFAULT '' COMMENT '公司照片',
    agreement_image varchar(100) NOT NULL DEFAULT '' COMMENT '协议照片',
    CONSTRAINT lcly_user_signup_pk PRIMARY KEY (id)
) COMMENT '用户申请表';

-- Table: lcly_userinfo
CREATE TABLE lcly_userinfo (
    id int NOT NULL AUTO_INCREMENT,
    user_id int NOT NULL,
    user_group_id int NOT NULL DEFAULT 0 COMMENT '用户等级id',
    avatar varchar(100) NOT NULL DEFAULT '' COMMENT '用户头像',
    sex enum("0","1","2") NOT NULL DEFAULT "0" COMMENT '性别:0=未知,1=男,2=女',
    truename varchar(100) NOT NULL DEFAULT '' COMMENT '真实姓名',
    login_times int NOT NULL DEFAULT 0 COMMENT '总登陆次数',
    lastlogin_time int NOT NULL DEFAULT 0 COMMENT '最后登陆时间',
    lastlogin_ip varchar(50) NOT NULL DEFAULT '' COMMENT '最后登陆ip地址',
    qq varchar(100) NOT NULL DEFAULT "" COMMENT 'QQ号码',
    wechat varchar(100) NOT NULL DEFAULT '' COMMENT '微信号码',
    experience int NOT NULL DEFAULT 0 COMMENT '用户经验数量',
    coin int NOT NULL DEFAULT 0 COMMENT '旅币数量',
    used_coin int NOT NULL DEFAULT 0 COMMENT '旅币总使用数量',
    money decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT '用户余额',
    CONSTRAINT lcly_userinfo_pk PRIMARY KEY (id)
) COMMENT '用户表';

-- Table: lcly_writeoff_log
CREATE TABLE lcly_writeoff_log (
    id int NOT NULL AUTO_INCREMENT,
    status enum("1","0","-1") NOT NULL DEFAULT "1" COMMENT '状态:1=正常,0=禁止,-1=删除',
    createtime int NOT NULL DEFAULT 0 COMMENT '注册时间',
    updatetime int NOT NULL DEFAULT 0 COMMENT '最后更新时间',
    user_id int NOT NULL COMMENT '用户id',
    order_id int NOT NULL,
    writeoff_user_id int NOT NULL COMMENT '核销用户id',
    resource_id int NOT NULL COMMENT '资源id',
    resource_user_id int NOT NULL COMMENT '资源商id',
    activity_id int NOT NULL COMMENT '对应活动id',
    activity_user_id int NOT NULL DEFAULT 0 COMMENT '活动发起userid',
    writeoff_once_num int NOT NULL DEFAULT 1 COMMENT '单次核销数量',
    writeoff_nums int NOT NULL DEFAULT 0 COMMENT '核销数量',
    CONSTRAINT lcly_writeoff_log_pk PRIMARY KEY (id)
);

-- End of file.

