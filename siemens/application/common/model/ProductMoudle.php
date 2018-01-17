<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/1/16 0016
 * Time: 17:10
 */

namespace app\common\model;

use think\Model;
class ProductMoudle extends Model
{
    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    public static $stateOk = 1;
    public static $stateDisable = 0;
    public static $stateDel = 2;
    public function getProductMoudles(){
        $data = $this->where('status',self::$stateOk)->select();
        return $data?$data:null;
    }
}