<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/19
  Time: 16:23
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


    <input type="hidden" name="id" value="${order.id}">
    <div class="layui-form-item">
        <label class="layui-form-label required">产品id</label>
        <div class="layui-input-block">
            <input type="text" name="pid" lay-verify="required" lay-reqtext="产品名称不能为空" placeholder="请输入产品名称" value="${order.pid}" class="layui-input">
            <tip>填写产品id</tip>
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label required">订单编号</label>
        <div class="layui-input-block">
            <input type="text" name="ono" lay-verify="required" lay-reqtext="订单编号不能为空" placeholder="请输入订单编号" value="${order.ono}" class="layui-input">
            <tip>填写订单编号</tip>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">数量</label>
        <div class="layui-input-block">
            <input type="text" name="num" lay-verify="required" lay-reqtext="数量不能为空" placeholder="请输入数量" value="${order.num}" class="layui-input">
            <tip>填写数量</tip>
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">结束日期</label>
        <div class="layui-input-block">
            <input type="text" name="ddl" id="date1" lay-verify="date" placeholder="yyyy-MM-dd" value="${order.ddl}" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">交付日期</label>
        <div class="layui-input-block">
            <input type="text" name="deliver" id="date2" lay-verify="date" placeholder="yyyy-MM-dd" value="${order.deliver}" autocomplete="off" class="layui-input">
        </div>
    </div>



    <input type="hidden" name="status"  value="0" >

    <div class="layui-form-item">
        <label class="layui-form-label required">收货人</label>
        <div class="layui-input-block">
            <input type="text" name="receiver" lay-verify="required" lay-reqtext="数量不能为空" placeholder="请输入数量" value="${order.receiver}" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">联系方式</label>
        <div class="layui-input-block">
            <input type="text" name="mobile" lay-verify="required" lay-reqtext="数量不能为空" placeholder="请输入数量" value="${order.mobile}" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">地址</label>
        <div class="layui-input-block">
            <input type="text" name="address" lay-verify="required" lay-reqtext="数量不能为空" placeholder="请输入数量" value="${order.address}" class="layui-input">
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
                url:"orderUpdateSubmit",
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