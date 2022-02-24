<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/19
  Time: 1:29
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
            工厂名：
            <div class="layui-inline">
                <input class="layui-input" name="name" id="name" autocomplete="off">
            </div>
            <button class="layui-btn" data-type="reload">搜索</button>
        </div>

        <script type="text/html" id="toolbarDemo">
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">开启</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">关闭</a>
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
            url: '<%=basePath%>/factoryA',//
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 100, title: 'ID', sort: true},
                {field: 'name', width: 150, title: '工厂名称'},
                {field: 'intro', width: 500, title: '工厂简介'},
                {field: 'uname', width: 100, title: '负责人'},
                {field: 'mobile', width: 100, title: '联系方式'},
                {field: 'status', width: 100, title: '状态',
                    templet:function(res){//类型
                        if(res.status == '1'){
                            return '<span class="layui-btn layui-btn-normal layui-btn-xs">正常</span>'
                        } else if(res.status == '2'){
                            return '<span class="layui-btn layui-btn-danger layui-btn-xs">关停</span>'
                        }
                    }
                },
                {title: '操作', minWidth: 100, toolbar: '#currentTableBar', align: "center"}
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
        function openFactory(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "factoryOpen",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('开启成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("开启失败");
                    }
                }
            })
        };

        function closeFactory(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "factoryClose",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('开启成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("开启失败");
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
                    title: '添加产品类型',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['80%', '80%'],
                    content: '<%=basePath%>/factoryAdd',
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
                        deleteFactoryByIds(ids ,index)
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
                layer.confirm('确定开启么', function (index) {
                    //开启工厂
                    openFactory(data.id,index);
                    layer.close(index);
                });

            }else if (obj.event === 'delete') {  // 监听删除操作
                layer.confirm('确定关闭么', function (index) {
                    //关闭工厂
                    closeFactory(data.id,index);
                    layer.close(index);
                });
            }
        });

    });

</script>

</body>
</html>