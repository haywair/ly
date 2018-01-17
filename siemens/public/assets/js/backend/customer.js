define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'customer/index',
                    add_url: 'customer/add',
                    edit_url: 'customer/edit',
                    del_url: 'customer/del',
                    multi_url: 'customer/multi',
                    dragsort_url: '',
                    table: 'customer',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                escape: false,
                pk: 'id',
                sortName: 'weigh',
                pagination: false,
                commonSearch: true,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id'),operate:false},
                        {field: 'status', title: __('状态'),formatter: Controller.api.formatter.status,searchList:{0:'隐藏',1:'正常',2:'删除'}},
                        {field: 'weigh', title: __('权重'),operate:false},
                        {field: 'customer_name', title: __('客户名称'), align: 'left',operate:'LIKE'},
                        {field: 'customer_mobile', title: __('客户电话'),operate:'LIKE'},
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
            },
            formatter : {
                status: function (value, row, index) {
                    //颜色状态数组,可使用red/yellow/aqua/blue/navy/teal/olive/lime/fuchsia/purple/maroon
                    var colorArr = {"1": 'success', "0": 'grey', "2": 'danger'};
                    var color = value && typeof colorArr[value] !== 'undefined' ? colorArr[value] : 'primary';
                    switch(value){
                        case '1':
                            value = '正常';
                            break;
                        case '0':
                            value = '隐藏';
                            break;
                        case '2':
                            value = "已删除";
                            break;
                    }
                    //渲染状态
                    var html = '<span class="text-' + color + '"><i class="fa fa-circle"></i> '+ value+ '</span>';
                    return html;
                }
            }
        }
    };
    return Controller;
});