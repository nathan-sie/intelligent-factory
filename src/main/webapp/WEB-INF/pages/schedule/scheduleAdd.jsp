<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/20
  Time: 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=product-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">



    <input type="hidden" name="oid"  value="${order.id}" >



    <input type="hidden" name="f_name"  value="${user.fname}" >




    <div class="layui-form-item">
        <label class="layui-form-label required">设备id</label>
        <div class="layui-input-block">
            <textarea name="did" class="layui-textarea" placeholder="请输入设备id"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">开始日期</label>
        <div class="layui-input-block">
            <input type="text" name="begin" id="date1" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">结束日期</label>
        <div class="layui-input-block">
            <input type="text" name="end" id="date2" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
    </div>
</div>
<script src="<%=basePath%>/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>

    layui.use(['form','laydate'], function () {
        var form = layui.form,
            layer = layui.layer,
            laydate=layui.laydate,
            $ = layui.$;

        //日期
        laydate.render({
            elem: '#date1',
            trigger:'click'
        });
        laydate.render({
            elem: '#date2',
            trigger:'click'
        });
        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var datas= data.field;
            $.ajax({
                url:"scheduleAddSubmit",
                type:"POST",
                data:datas,
                success:function (result){
                    if(result.code == 0){
                        layer.msg('添加成功',{
                            icon:6,
                            time:500,
                        },function (){
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        })
                    }
                    else{
                        layer.msg("添加失败");
                    }

                }
            })



            return false;
        });

    });
</script>
</body>