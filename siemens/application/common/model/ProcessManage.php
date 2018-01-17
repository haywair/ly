<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/1/16 0016
 * Time: 18:07
 */

namespace app\common\model;

use think\Model;
class ProcessManage extends Model
{
    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    public static $stateOk = 1;
    public static $stateDisable = 0;
    public static $stateDel = 2;
    public function getProcessData(){
        $data = $this->where('status',self::$stateOk)->column('process_name','id');
        return $data?$data:null;
    }



}