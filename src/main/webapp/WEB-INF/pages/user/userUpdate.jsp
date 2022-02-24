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
<%@ page isELIgnored="false" %>
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
    <input type="hidden" name="id"  value="${user.id}" >


    <div class="layui-form-item">
        <label class="layui-form-label required">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="username" lay-verify="required" value="${user.username}" class="layui-input">
            <tip>修改用户名</tip>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">密码</label>
        <div class="layui-input-block">
            <input type="text" name="password" lay-verify="required" value="${user.password}" class="layui-input">
            <tip>修改密码</tip>
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label required">姓名</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-verify="required" value="${user.name}" class="layui-input">
            <tip>修改姓名</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">手机号码</label>
        <div class="layui-input-block">
            <input type="text" name="mobile" lay-verify="required" value="${user.mobile}" class="layui-input">
            <tip>修改手机号码</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">角色id</label>
        <div class="layui-input-block">
            <input type="text" name="rid" lay-verify="required" value="${user.rid}" class="layui-input">
            <tip>修改角色id</tip>
        </div>
    </div>







    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认修改</button>
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
            $.ajax({
                url:"userUpdateSubmit",
                type:"POST",
                //data:datas,
                contentType:"application/json",
                data:JSON.stringify(datas),
                success:function (result){
                    if(result.code == 0){
                        layer.msg('修改成功',{
                            icon:6,
                            time:500,
                        },function (){
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        })
                    }
                    else{
                        layer.msg("修改失败");
                    }

                }
            })



            return false;
        });

    });
</script>
</body>
</html>
