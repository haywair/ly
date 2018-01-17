define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'user/index',
                    add_url: 'user/add',
                    edit_url: 'user/edit',
                    del_url: 'user/del',
                    multi_url: 'user/multi',
                    table: 'user',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                commonSearch:'true',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id'),operate:false},
                        {field: 'username', title: __('Username'),operate:'LIKE'},
                        {field: 'user_nickname', title: __('Nickname'),operate:'LIKE'},
                        {field: 'email', title: __('Email'),operate:false},
                        {field: 'user_mobile', title: __('Mobile'),operate:'LIKE'},
                        // {field: 'avatar', title: __('Avatar'), formatter: Table.api.formatter.image},
                        {field: 'groups_text', title: __('分组'), operate:false, formatter: Table.api.formatter.label},
                        {field: 'loginfailure', title: __('Loginfailure'), visible: true,operate:false},
                        {field: 'logintime', title: __('Logintime'), operate: false, visible: true, formatter: Table.api.formatter.datetime},
                        {field: 'createtime', title: __('Createtime'), operate: false, visible: true, formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('Updatetime'), operate: false, visible: true, formatter: Table.api.formatter.datetime},
                        {field: 'status', title: __('Status'), formatter: Table.api.formatter.status,searchList:{0:'隐藏',1:'正常',2:'删除'}},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});