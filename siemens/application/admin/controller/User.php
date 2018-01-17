<?php

namespace app\admin\controller;
use app\admin\model\AuthGroup;
use app\admin\model\FrontAuthGroupAccess;
use app\common\controller\Backend;
use fast\Random;
use app\admin\model\User as Us;
use think\Exception;

/**
 * 会员管理
 *
 * @icon fa fa-user-o
 */
class User extends Backend
{

    protected $noNeedRight = ['selectpage'];
    protected $model = null;
    protected $childrenGroupIds = [];
    protected $childrenAdminIds = [];

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new Us();

        $this->childrenAdminIds = $this->auth->getChildrenAdminIds(true);
        $this->childrenGroupIds = $this->auth->getChildrenGroupIds();

        $groupName = (new AuthGroup())->where('id', 'in', $this->childrenGroupIds)
            ->column('id,name');

        foreach ($groupName as $k => &$v)
        {
            $v = __($v['name']);
        }
        unset($v);

        $this->view->assign('groupdata', $groupName);
        $this->assignconfig("admin", ['id' => $this->auth->id]);
    }


    /**
     * 查看
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);
        if ($this->request->isAjax()) {
            $childrenGroupIds = $this->auth->getFrontChildrenAdminIds(true);
            $groupName = AuthGroup::where('id', 'in', $childrenGroupIds)
                ->column('id,name');
            $authGroupList = FrontAuthGroupAccess::where('group_id', 'in', $childrenGroupIds)
                ->field('uid,group_id')
                ->select();

            $adminGroupName = [];
            foreach ($authGroupList as $k => $v)
            {
                if (isset($groupName[$v['group_id']]))
                    $adminGroupName[$v['uid']][$v['group_id']] = $groupName[$v['group_id']];
            }
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('pkey_name')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            /*$total = $this->model
                ->where($where)
                ->order($sort, $order)
                ->count();*/
            $total = $this->model->count();

            $list = $this->model
                ->where($where)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();
            foreach ($list as $k => &$v)
            {
                $groups = isset($adminGroupName[$v['id']]) ? $adminGroupName[$v['id']] : [];
                $key = array_keys($groups);
                $values = array_values($groups);
                $v['groups'] = implode(',', $key);
                $v['groups_text'] = '';
                if($values){
                    foreach($values as $kr=>$vr){
                        $v['groups_text'] .= $vr['name'].' ';
                    }
                }
            }
            unset($v);
            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }

    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost())
        {
            $params = $this->request->post("row/a");
            if ($params)
            {
                $params['salt'] = Random::alnum();
                $params['password'] = md5(md5($params['password']) . $params['salt']);
               // $params['avatar'] = '/assets/img/avatar.png'; //设置新管理员默认头像。

                $user = $this->model->create($params);
                $group = $this->request->post("group/a");

                //过滤不允许的组别,避免越权
                $group = array_intersect($this->childrenGroupIds, $group);
                $dataset = [];
                foreach ($group as $value)
                {
                    $dataset[] = ['uid' =>$user['id'], 'group_id' => $value];
                }
                (new FrontAuthGroupAccess())->saveAll($dataset);
                $this->success();
            }
            $this->error();
        }
        return $this->view->fetch();
    }
    /**
     * 修改
     */
    public function edit($ids = NULL)
    {
        $row = $this->model->get(['id' => $ids]);
        if (!$row)
            $this->error(__('No Results were found'));
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");

            if ($params['password']) {
                $password = $params['password'];
                $salt = \fast\Random::alnum();
                $params = array_merge($params, ['password' => \app\user\library\Auth::instance()->getEncryptPassword($password, $salt), 'salt' => $salt]);
            } else {
                unset($params['password']);
            }
            $this->request->post(['row' => $params]);
            $uid = $params['id'];unset($params['id']);
            $res = $this->model->where('id',$uid)->update($params);
            if($res) {
                //分组
                $group = $this->request->post("group/a");

                //过滤不允许的组别,避免越权
                $group = array_intersect($this->childrenGroupIds, $group);
                $dataset = [];
                foreach ($group as $value) {
                    $dataset[] = ['uid' => $uid, 'group_id' => $value];
                }
                (new FrontAuthGroupAccess())->where('uid',$uid)->delete();
                (new FrontAuthGroupAccess())->saveAll($dataset);
                $this->success();
            }
            $this->error('修改失败');
        }
        $grouplist = $this->auth->getFrontGroups($row['id']);
        $groupids = [];
        foreach ($grouplist as $k => $v)
        {
            $groupids[] = $v['id'];
        }
        $this->view->assign("row", $row);
        $this->view->assign("groupids", $groupids);
        return $this->view->fetch();
    }

    /**
     * 快捷搜索
     * @internal
     */
    public function selectpage()
    {
        $origin = parent::selectpage();
        $result = $origin->getData();
        $list = [];
        foreach ($result['list'] as $k => $v) {
            $list[] = ['id' => $v->id, 'nickname' => $v->nickname, 'username' => $v->username];
        }
        $result['list'] = $list;
        return json($result);
    }

}
