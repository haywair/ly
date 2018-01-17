<?php

namespace app\user\controller;

use app\user\library\Auth;
use app\user\model\User;
use think\Cookie;
use think\Session;
use think\Validate;
use think\Controller;

/**
 * 会员中心
 */
class Index extends Controller
{

    /**
     * 认证类
     * @var Auth  
     */
    protected $auth = null;

    /**
     * 会员模型
     * @var User 
     */
    protected $user = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->view->engine->layout('layout/common');
        $this->auth = Auth::instance();
        $this->auth->init();
        $this->user = $this->auth->getModel();
        $this->view->assign('user', $this->user);
    }

    public function index()
    {
        return $this->view->fetch();
    }

    /**
     * 注册会员
     */
    public function register()
    {
        $url = $this->request->request('url', url('user/index/index'));
        if ($this->auth->check())
            $this->error(__('You\'ve logged in, do not login again'), $url);
        Session::set('redirect_url', $url);
        if ($this->request->isPost())
        {
            $username = $this->request->post('username');
            $password = $this->request->post('password');
            $email = $this->request->post('email');
            $mobile = $this->request->post('mobile', '');
            $captcha = $this->request->post('captcha');
            $token = $this->request->post('__token__');
            $rule = [
                'username'  => 'require|length:6,30',
                'password'  => 'require|length:6,30',
                'email'     => 'require|email',
                'mobile'    => 'regex:/^1\d{10}$/',
                'captcha'   => 'require|captcha',
                '__token__' => 'token',
            ];

            $msg = [
                'username.require' => 'Username can not be empty',
                'username.length'  => 'Username must be 6 to 30 characters',
                'password.require' => 'Password can not be empty',
                'password.length'  => 'Password must be 6 to 30 characters',
                'captcha.require'  => 'Captcha can not be empty',
                'captcha.captcha'  => 'Captcha is incorrect',
                'email'            => 'Email is incorrect',
                'mobile'           => 'Mobile is incorrect',
            ];
            $data = [
                'username'  => $username,
                'password'  => $password,
                'email'     => $email,
                'mobile'    => $mobile,
                'captcha'   => $captcha,
                '__token__' => $token,
            ];
            $validate = new Validate($rule, $msg);
            $result = $validate->check($data);
            if (!$result)
            {
                $this->error($validate->getError());
                return FALSE;
            }

            if ($this->auth->register($username, $password, $email, $mobile))
            {
                $synchtml = '';

                $referer = Cookie::get('referer_url');
                redirect()->restore();
                $this->success(__('Sign up successful') . $synchtml);
            }
            else
            {
                $this->error($this->auth->getError());
            }
        }
        return $this->view->fetch();
    }

    /**
     * 会员登录
     */
    public function login()
    {
        $url = $this->request->request('url', url('user/index/index'));
        if ($this->auth->check())
            $this->error(__('You\'ve logged in, do not login again'), $url);
        Session::set('redirect_url', $url);
        if ($this->request->isPost())
        {
            $account = $this->request->post('account');
            $password = $this->request->post('password');
            $token = $this->request->post('__token__');
            $rule = [
                'account'   => 'require|length:6,50',
                'password'  => 'require|length:6,30',
                '__token__' => 'token',
            ];

            $msg = [
                'account.require'  => 'account can not be empty',
                'password.require' => 'Password can not be empty',
                'password.length'  => 'Password must be 6 to 30 characters',
            ];
            $data = [
                'account'   => $account,
                'password'  => $password,
                '__token__' => $token,
            ];
            $validate = new Validate($rule, $msg);
            $result = $validate->check($data);
            if (!$result)
            {
                $this->error($validate->getError());
                return FALSE;
            }
            if ($this->auth->login($account, $password))
            {
                $synchtml = '';

                $this->success(__('Logged in successful') . $synchtml, $url);
            }
            else
            {
                $this->error($this->auth->getError());
            }
        }
        return $this->view->fetch();
    }

    /**
     * 注销登录
     */
    function logout()
    {
        //注销本站
        $this->auth->logout();
        $synchtml = '';

        $this->success(__('Logout successful') . $synchtml, url('user/index/index'));
    }


    /**
     * 修改密码
     */
    public function changepwd()
    {
        if ($this->request->isPost())
        {
            $oldpassword = $this->request->post("oldpassword");
            $newpassword = $this->request->post("newpassword");
            $ret = $this->auth->changepwd($newpassword, $oldpassword);
            if ($ret)
            {
                $this->auth->logout();

                $synchtml = '';
                $this->success(__('Change password successful') . $synchtml, url('user/index/login'));
            }
            else
            {
                $this->error($this->auth->getError());
            }
        }
        return $this->view->fetch();
    }

}
