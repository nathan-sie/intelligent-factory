<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/19
  Time: 23:46
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
            设备id：
            <div class="layui-inline">
                <input class="layui-input" name="name" id="id" value="${device.id}" autocomplete="off" disabled>
            </div>

            设备名称：
            <div class="layui-inline">
                <input class="layui-input" name="name" id="name" value="${device.name}" autocomplete="off" disabled>
            </div>

        </div>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
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
            url: '<%=basePath%>capacityAll',//
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 350, title: 'ID', sort: true},
                {field: 'did', width: 100, title: '设备id'},
                {field: 'pid', width: 100, title: '产品id'},
                {field: 'capacity', width: 100, title: '类型名称'},
                {title: '操作', minWidth: 300, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [5,10, 15, 20, 25, 50, 100],
            limit: 5,
            page: true,
            skin: 'line',
            id: 'testReload'
        });

        var $ = layui.$, active = {
            reload: function(){
                var name = $('#name').val();
                console.log(name)

                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {

                        name: name

                    }
                }, 'data');
            }
        };

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        /**
         * 提交删除功能
         */
        function deleteCapacityByIds(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "capacityDelete",
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



        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加产能',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '<%=basePath%>capacityAdd',
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
                if(data.length==0){
                    layer.msg("请选择要删除的记录信息");
                }else {
                    //获取记录信息的id集合
                    var ids=getCheckId(data);
                    layer.confirm("真的删除行么", function (index) {
                        deleteCapacityByIds(ids ,index)
                        layer.close(index);
                    });

                }

            }


            /*else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }*/
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



        /**
         * tool操作栏监听事件
         */
        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '编辑产能',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '<%=basePath%>queryCapacityById?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            }else if (obj.event === 'delete') {  // 监听删除操作
                layer.confirm('真的删除行么', function (index) {
                    //调用删除功能
                    deleteCapacityByIds(data.id,index);
                    layer.close(index);
                });
            }
        });

    });

</script>

</body>
</html>
