define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'productmoudle/index',
                    add_url: 'productmoudle/add',
                    edit_url: 'productmoudle/edit',
                    del_url: 'productmoudle/del',
                    multi_url: 'productmoudle/multi',
                    table: 'productmoudle',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                commonSearch:true,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id'),operate:false},
                        {field: 'name', title: __('名称'),operate:'LIKE'},
                        {field: 'status', title: __('状态'),formatter: Controller.api.formatter.status,searchList:{0:'隐藏',1:'正常',2:'删除'}},
                        {field: 'weigh', title: __('权重'),operate:false},
                        {field: 'pid', title: __('主模块'),searchList:Controller.api.formatter.getmoudles()},
                        {field: 'moudle_content', title: __('简述'),operate:false},
                        {field: 'createtime', title: __('创建时间'), operate: false, visible: true, formatter: Table.api.formatter.datetime},
                        {field: 'updatetime', title: __('更新时间'), operate: false, visible: true, formatter: Table.api.formatter.datetime},
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
                },
                promoudles:function(value,row,index){
                    var html = '<span class="text">'+row.product_id+'</span>';
                    return html;
                },
                getmoudles:function(){
                    var jsonMoudles = {};
                    $.ajax({
                        url:'ajax/getMoudles',
                        type:'get',
                        data:{},
                        async:false,
                        dataType:'json',
                        success:function(result){
                            if(result.code == 1){
                                $.each(result.data,function(i,item){
                                    jsonMoudles[item.id] = item.name;
                                });
                            }
                        }
                    });
                    return jsonMoudles;
                },
            }
        }
    };
    return Controller;
});