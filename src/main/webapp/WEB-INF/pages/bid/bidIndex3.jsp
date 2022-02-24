<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/19
  Time: 20:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="demoTable">


        </div>


        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="choose">选标</a>
        </script>


    </div>
</div>
<script src="<%=basePath%>/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>

    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '<%=basePath%>bidD',//
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 100, title: 'ID', sort: true},
                {templet:'<div>{{d.order.ono}}</div>',width: 250,title: '订单编号'},
                {field: 'uname', width: 100, title: '用户'},
                {field: 'f_name', width: 100, title: '工厂名'},
                {field: 'price', width: 200, title: '价格'},
                {field: 'status', width: 100, title: '状态',
                    templet:function(res){//类型
                        if(res.status == '1'){
                            return '<span class="layui-btn layui-btn-normal layui-btn-xs">已中标</span>'
                        } if(res.status == '2'){
                            return '<span class="layui-btn layui-btn-danger layui-btn-xs">未中标</span>'
                        }if(res.status == '3'){
                            return '<span class="layui-btn layui-btn-warm layui-btn-xs">已排产</span>'
                        }if(res.status == '4'){
                            return '<span class="layui-btn layui-btn-warm layui-btn-xs">已结束</span>'
                        }
                    }
                },
                {title: '操作', minWidth: 200, toolbar: '#currentTableBar', align: "center"}

            ]],
            limits: [5,10, 15, 20, 25, 50, 100],
            limit: 5,
            page: true,
            skin: 'line',
            id: 'testReload'
        });

        var $ = layui.$, active = {
            reload: function(){
                var status = $('#status').val();

                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {

                        status:status

                    }
                }, 'data');
            }
        };

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });
        function chooseBid(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "bidChoose",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('选标成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("选标失败");
                    }
                }
            })
        };

        function chooseOrder(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "orderChoose",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('开启成功', {
                            icon: 6,
                            time: 500
                        }, function () {

                        });
                    } else {
                        layer.msg("开启失败");
                    }
                }
            })
        };




        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'choose') {  // 监听删除操作
                layer.confirm('确定选标么', function (index) {
                    //调用删除功能
                    chooseBid(data.id,index);
                    chooseOrder(ids ,index);
                    layer.close(index);
                });
            }
        });
    });



</script>

</body>