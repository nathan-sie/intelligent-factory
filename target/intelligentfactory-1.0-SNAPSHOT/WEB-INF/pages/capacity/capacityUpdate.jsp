<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/20
  Time: 12:40
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

    <input type="hidden" name="id"  value="${capacity.id}" >
    <input type="hidden" name="did"  value="${capacity.did}" >

<%--
    <div class="layui-form-item">
        <label class="layui-form-label required">设备名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-reqtext="设备类型不能为空" value="${device.name}" disabled class="layui-input" >
            <tip>填写设备名称</tip>
        </div>
    </div>
--%>

    <div class="layui-form-item">
        <label class="layui-form-label required">产品id</label>
        <div class="layui-input-block">
            <input type="text" name="pid" lay-verify="required" lay-reqtext="" placeholder="" value="${capacity.pid}" class="layui-input">
            <tip>填写设备编号</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">产能</label>
        <div class="layui-input-block">
            <input type="text" name="capacity" placeholder="请输入设备规格" value="${capacity.capacity}" class="layui-input">
            <tip>填写规格</tip>
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
            $.ajax({
                url:"capacityUpdateSubmit",
                type:"POST",
                contentType:"application/json",
                data:JSON.stringify(datas),
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
</html>
