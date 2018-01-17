<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/1/16 0016
 * Time: 17:54
 */

namespace app\admin\controller;
use fast\Tree;
use app\common\controller\Backend;
class Processmanage extends Backend
{
    protected $model = null;
    protected $productMoudles;
    protected $processData;
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('ProcessManage');
        $this->productMoudles = model('ProductMoudle')->getProductMoudles();
        $this->processData = $this->model->getProcessData();
        $this->view->assign('moudles',$this->productMoudles);

        $tree = Tree::instance();
        $tree->init($this->model->order('weigh desc,id desc')->select(), 'pid');
        $this->processlist = $tree->getTreeList($tree->getTreeArray(0), 'process_name');
        $processSdata = [0 => ['process_name' => __('未选中')]];
        foreach ($this->processlist as $k => $v)
        {
            $processSdata[$v['id']] = $v;
        }
        $this->view->assign('processSdata',$processSdata);
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
                $list[$k]['process_content'] = htmlspecialchars_decode(strip_tags($v['process_content']));
                $v['product_id'] = $this->productMoudles[$v['product_id']]['name'];
                if($v['pid'] > 0){
                    $v['pid'] = $this->processData[$v['pid']]['process_name'];
                }
            }
            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }
}