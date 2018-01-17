<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/1/17 0017
 * Time: 11:00
 */

namespace app\admin\controller;

use app\common\controller\Backend;
class Customer extends Backend
{
    protected $model = null;
    protected $productMoudles;
    protected $processData;
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('Customer');
    }

    /**
     * 查看
     */
    public function index()
    {
        if ($this->request->isAjax())
        {
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            /*$total = $this->model
                ->where($where)
                ->order($sort, $order)
                ->count();*/
            $total = $this->model->where($where)->count();
            $list = $this->model
                ->where($where)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();
            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }

}