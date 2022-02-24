<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/17
  Time: 21:14
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
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
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



    <div class="layui-form-item">
        <label class="layui-form-label required">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="username" lay-verify="required" lay-reqtext="用户名不能为空" placeholder="请输入用户名" value="" class="layui-input">
            <tip>填写用户名</tip>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">密码</label>
        <div class="layui-input-block">
            <input type="text" name="password" lay-verify="required" lay-reqtext="密码不能为空" placeholder="请输入密码" value="" class="layui-input">
            <tip>填写密码</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">姓名</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-verify="required" lay-reqtext="姓名不能为空" placeholder="请输入姓名" value="" class="layui-input">
            <tip>填写自己姓名</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">手机号码</label>
        <div class="layui-input-block">
            <input type="text" name="mobile" lay-verify="required" lay-reqtext="手机号码不能为空" placeholder="请输入手机号码" value="" class="layui-input">
            <tip>填写自己手机号码</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">角色ID</label>
        <div class="layui-input-block">
            <input type="radio" name="rid" value="2" title="云工厂" checked>
            <input type="radio" name="rid" value="3" title="经销商" >
            <input type="radio" name="rid" value="1" title="超级管理员" disabled>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">工厂名称</label>
        <div class="layui-input-block">
            <input type="text" name="fname" lay-verify="required" lay-reqtext="工厂名称不能为空" placeholder="请输入工厂名称" value="" class="layui-input">
            <tip>填写自己姓名</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">工厂简介</label>
        <div class="layui-input-block">
            <input type="text" name="intro" lay-verify="required" lay-reqtext="工厂简介不能为空" placeholder="请输入工厂简介" value="" class="layui-input">
            <tip>填写工厂简介</tip>
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
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var datas= data.field;
            if(data.field.rid == 3){
                data.field.fname = null;
                data.field.intro = null;
            }
            $.ajax({
                url:"userAddSubmit",
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

            if(data.field.rid == 2){
                $.ajax({
                    url:"factoryAddSubmit",
                    type:"POST",
                    data:datas,
                    success:function (result){
                        if(result.code == 0){
/*                            layer.msg('添加成功',{
                                icon:6,
                                time:500,
                            },function (){
                                parent.window.location.reload();
                                var iframeIndex = parent.layer.getFrameIndex(window.name);
                                parent.layer.close(iframeIndex);
                            })*/
                        }
                        else{
                            layer.msg("添加失败");
                        }

                    }
                })
            }


            return false;
        });

    });
</script>
</body>
</html>