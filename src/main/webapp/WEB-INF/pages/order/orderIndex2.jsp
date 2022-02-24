<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/19
  Time: 0:01
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
            <div class="layui-form-item layui-form">
<%--                状态：
                <div class="layui-inline" >
                    <select class="layui-input" name="status" id="status">
                        <option value="1">已开启</option>
                        <option value="2">已结束</option>
                        <option value="3">已完成</option>
                    </select>
                </div>
                <button class="layui-btn" data-type="reload">搜索</button>--%>
            </div>

        </div>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add">添加</button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete">删除</button>
            </div>
        </script>


        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn layui-btn-xs data-count-edit" lay-event="edit">修改</a>
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="issue">开启</a>
            <a class="layui-btn layui-btn-xs layui-btn-warm data-count-delete" lay-event="receive">收货</a>
            <a class="layui-btn layui-btn-xs layui-btn-primary data-count-delete" lay-event="bid">标书</a>
            <a class="layui-btn layui-btn-xs layui-btn-primary data-count-delete" lay-event="delete">删除</a>
        </script>
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

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
            url: '<%=basePath%>/orderA',//
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 100, title: 'ID', sort: true},
                {field: 'ono', width: 200, title: '订单编号'},
                {field: 'pid', width: 100, title: '产品ID'},
                {field: 'num', width: 100, title: '数量'},
                {field: 'ddl', width: 200, title: '截止日期'},
                {field: 'deliver', width: 200, title: '交付日期'},
                {field: 'status', width: 100, title: '状态',
                    templet:function(res){//类型
                        if(res.status == '0'){
                            return '<span class="layui-btn layui-btn-primary layui-btn-xs">未开启</span>'
                        }if(res.status == '1'){
                            return '<span class="layui-btn layui-btn layui-btn-xs">已开启</span>'
                        }if(res.status == '2'){
                            return '<span class="layui-btn layui-btn-warm layui-btn-xs">已接单</span>'
                        }if(res.status == '3'){
                            return '<span class="layui-btn layui-btn-normal layui-btn-xs">已排产</span>'
                        } if(res.status == '4'){
                            return '<span class="layui-btn layui-btn-danger layui-btn-xs">已发货</span>'
                        }if(res.status == '5'){
                            return '<span class="layui-btn layui-btn-primary layui-btn-xs">已完成</span>'
                        }
                    }
                },
                {field: 'receiver', width: 100, title: '收货人'},
                {field: 'mobile', width: 75, title: '联系方式'},
                {field: 'address', width: 75, title: '地址'},
                {title: '操作', minWidth: 300, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [5,10, 15, 20, 25, 50, 100],
            limit: 10,
            page: true,
            skin: 'line',
            id: 'testReload'
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        function getCheckId(data){
            var arr = new Array();
            for(var i=0;i<data.length;i++){
                arr.push(data[i].id)
            }
            return arr.join(",");
        }


        function deleteOrderByIds(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "orderDelete",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('删除成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("删除失败");
                    }
                }
            })
        };

        function issueOrder(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "orderIssue",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('发布成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("发布失败");
                    }
                }
            })
        };

        function receiveOrder(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "orderReceive",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('收货成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("收货失败");
                    }
                }
            })
        };

        function chooseOrder2(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "orderChoose2",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功

                    } else {

                    }
                }
            })
        };




        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });




        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加订单',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '<%=basePath%>/orderAdd',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            }
            else if (obj.event === 'delete') {
                /*
                   1、提示内容，必须删除大于0条
                   2、获取要删除记录的id信息
                   3、提交删除功能 ajax
                 */
                //获取选中的记录信息
                var checkStatus = table.checkStatus(obj.config.id)
                var data = checkStatus.data;
                if(data.length=== 0){
                    layer.msg("请选择要删除的记录信息");
                }else if(data.status !== 5){
                    layer.msg("未完成的项目无法删除");
                }
                else  {
                    //获取记录信息的id集合
                    var ids=getCheckId(data);
                    layer.confirm("真的删除行么", function (index) {
                        deleteOrderByIds(ids ,index)
                        layer.close(index);
                    });

                }

            }
        });


        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'issue') {
                layer.confirm('确定开启么', function (index) {
                    //开启工厂
                    issueOrder(data.id,index);
                    layer.close(index);
                });

            }else if (obj.event === 'receive') {  // 监听删除操作
                layer.confirm('确定收货么', function (index) {
                    //关闭工厂
                    receiveOrder(data.id,index);
                    layer.close(index);
                });
            }else if(obj.event === 'bid'){
                var index = layer.open({
                    title: '看标书',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '<%=basePath%>queryOrderById4?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });


                    //调用删除功能
                    chooseOrder2(data.id,index);

                return false;
            }else if(obj.event === 'edit'){
                if(data.status !== 0){
                        layer.msg("已发布的订单无法修改");
                }else{
                    var index2 = layer.open({
                    title: '修改订单',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '<%=basePath%>queryOrderById?id='+data.id,
                });
                    $(window).on("resize", function () {
                        layer.full(index2);
                    });

                }

            }else if (obj.event === 'delete') {

                // 监听删除操作
                layer.confirm('真的删除订单么', function (index) {
                    //调用删除功能
                    deleteOrderByIds(data.id,index);
                    layer.close(index);
                });
            }
        })











    });

</script>

</body>
</html>
