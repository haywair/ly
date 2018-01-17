<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/1/17 0017
 * Time: 11:02
 */

namespace app\common\model;

use think\Model;
class Customer extends Model
{
    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    public static $stateOk = 1;
    public static $stateDisable = 0;
    public static $stateDel = 2;

}