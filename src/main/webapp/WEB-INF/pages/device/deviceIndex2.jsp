<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/19
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
            设备名称：
            <div class="layui-inline">
                <input class="layui-input" name="name" id="name" autocomplete="off">
            </div>

            <button class="layui-btn" data-type="reload">高级查询</button>
        </div>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
                <button class="layui-btn layui-btn-sm layui-btn-warm data-delete-btn" lay-event="zuyong"> 租用 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-warm layui-btn-xs data-count-edit" lay-event="change">改变</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
            <a class="layui-btn layui-btn layui-btn-xs data-count-edit" lay-event="open">开启</a>
            <a class="layui-btn layui-btn-xs layui-btn-warm data-count-edit" lay-event="close">关闭</a>
            <a class="layui-btn layui-btn-xs layui-btn-warm data-count-edit" lay-event="cap">配置产能</a>
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
            url: '<%=basePath%>deviceA',//
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 100, title: 'ID', sort: true},
                {field: 'dno', width: 250, title: '设备编号'},
                {field: 'name', width: 200, title: '设备名称'},
                {templet:'<div>{{d.deviceType.name}}</div>', width: 100, title: '类型名称'},
                {field: 'f_name', width: 125, title: '工厂名称'},
                {field: 'norms', width: 125, title: '规格'},
                {field: 'intro', width: 200, title: '设备介绍'},
                {field: 'status', width: 100, title: '设备状态',
                    templet:function(res){//类型
                        if(res.status == '1'){
                            return '<span class="layui-btn layui-btn-warm layui-btn-xs">空闲</span>'
                        } else if(res.status == '2'){
                            return '<span class="layui-btn layui-btn-normal layui-btn-xs">开启</span>'
                        }else if(res.status == '3'){
                            return '<span class="layui-btn layui-btn-danger layui-btn-xs">关停</span>'
                        }
                    }
                },
                {field: 'rent', width: 100, title: '租用状态',
                    templet:function(res){//类型
                        if(res.rent == '1'){
                            return '<span class="layui-btn layui-btn-warm layui-btn-xs">工厂设备</span>'
                        } else if(res.rent == '2'){
                            return '<span class="layui-btn layui-btn layui-btn-xs">已被租用</span>'
                        }else if(res.rent == '3'){
                            return '<span class="layui-btn layui-btn-normal layui-btn-xs">空闲</span>'
                        }
                    }
                },
                {title: '操作', minWidth: 400, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [5,10, 15, 20, 25, 50, 100],
            limit: 10,
            page: true,
            skin: 'line',
            id: 'testReload'
        });




        $.get("findAllDeviceList",{},function (data) {
            var list=data;
            var select=document.getElementById("tid");
            if(list!=null|| list.size()>0){
                for(var c in list){
                    var option=document.createElement("option");
                    option.setAttribute("value",list[c].id);
                    option.innerText=list[c].name;
                    select.appendChild(option);
                }
            }
            form.render('select');
        },"json")

        /*
                $.get("findAllFactoryList",{},function (data) {
                    var list=data;
                    var select=document.getElementById("fid");
                    if(list!=null|| list.size()>0){
                        for(var c in list){
                            var option=document.createElement("option");
                            option.setAttribute("value",list[c].id);
                            option.innerText=list[c].name;
                            select.appendChild(option);
                        }
                    }
                    form.render('select');
                },"json")
        */


        var $ = layui.$, active = {
            reload: function(){
                var name = $('#name').val();
                var tid= $('#tid').val();


                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        name: name,
                        tid : tid

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
        function deleteDeviceByIds(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "deviceDelete",
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

        function openDevice(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "deviceOpen",
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

        function closeDevice(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "deviceClose",
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
                    title: '添加设备信息',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['80%', '80%'],
                    content: '<%=basePath%>/deviceAdd2',
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
                        deleteDeviceByIds(ids ,index)
                        layer.close(index);
                    });

                }

            }else if(obj.event === 'zuyong'){
                var index = layer.open({
                    title: '租用设备',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['80%', '80%'],
                    content: '<%=basePath%>/deviceRent',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });

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
                    title: '编辑设备',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['80%', '80%'],
                    content: '<%=basePath%>queryDeviceById?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            }else if (obj.event === 'delete') {  // 监听删除操作
                layer.confirm('真的删除行么', function (index) {
                    //调用删除功能
                    deleteDeviceByIds(data.id,index);
                    layer.close(index);
                });
            }
            else if (obj.event === 'open') {  // 监听删除操作
                layer.confirm('真的开启么', function (index) {
                    //调用删除功能
                    openDevice(data.id,index);
                    layer.close(index);
                });
            }
            else if (obj.event === 'close') {  // 监听删除操作
                layer.confirm('真的关闭么', function (index) {
                    //调用删除功能
                    closeDevice(data.id,index);
                    layer.close(index);
                });
            }else if(obj.event === 'change'){
                var index = layer.open({
                    title: '编辑设备',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '<%=basePath%>queryDeviceById2?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            }else if(obj.event === 'cap'){
                var index = layer.open({
                    title: '配置产能',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '<%=basePath%>queryDeviceById3?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            }
        });

    });

</script>

</body>
