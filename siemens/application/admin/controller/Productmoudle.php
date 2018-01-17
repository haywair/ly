<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/1/16 0016
 * Time: 16:56
 */

namespace app\admin\controller;
use fast\Tree;
use app\common\controller\Backend;
class Productmoudle extends Backend
{
    protected $model = null;
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('ProductMoudle');
        $this->productMoudles = model('ProductMoudle')->getProductMoudles();

        $tree = Tree::instance();
        $tree->init($this->model->order('weigh desc,id desc')->select(), 'pid');
        $this->moudlelist = $tree->getTreeList($tree->getTreeArray(0), 'name');
        $moudleData = [0 => ['name' => __('未选中')]];
        foreach ($this->moudlelist as $k => $v)
        {
            $moudleData[$v['id']] = $v;
        }
        $this->view->assign('moudleData',$moudleData);
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
            foreach($list as $k=>$v){
                $list[$k]['moudle_content'] = htmlspecialchars_decode(strip_tags($v['moudle_content']));
                if($v['pid'] > 0){
                    $v['pid'] = $this->productMoudles[$v['pid']]['name'];
                }
            }
            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }

}