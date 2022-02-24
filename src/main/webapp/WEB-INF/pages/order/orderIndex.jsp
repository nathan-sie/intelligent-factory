<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/18
  Time: 0:47
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
                状态：
                <div class="layui-inline" >
                    <select class="layui-input" name="status" id="status">
                        <option value="">请选择</option>
                        <option value="0">未开启</option>
                        <option value="1">已开启</option>
                        <option value="2">已接单</option>
                        <option value="3">已排产</option>
                        <option value="4">已发货</option>
                        <option value="5">已完成</option>
                    </select>
                </div>
                <button class="layui-btn" data-type="reload">搜索</button>
            </div>

        </div>


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
            url: '<%=basePath%>/orderAll',//
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
                {field: 'mobile', width: 100, title: '联系方式'},
                {field: 'address', width: 100, title: '地址'},
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














    });

</script>

</body>
</html>