<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/19
  Time: 11:14
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
    <label class="layui-form-label required">设备名称</label>
    <div class="layui-input-block">
      <input type="text" name="name" lay-verify="required" lay-reqtext="设备类型不能为空" placeholder="请输入设备类型名称" value="" class="layui-input">
      <tip>填写设备名称</tip>
    </div>
  </div>


  <div class="layui-form-item">
    <label class="layui-form-label required">类型名称</label>
    <div class="layui-input-block">
      <select name="tid" id="tid" lay-verify="required">
        <option value="">请选择</option>
      </select>
    </div>
  </div>

  <div class="layui-form-item">
    <label class="layui-form-label required">编号</label>
    <div class="layui-input-block">
      <input type="text" name="dno" lay-verify="required" lay-reqtext="设备编号不能为空" placeholder="请输入设备编号" value="" class="layui-input">
      <tip>填写设备编号</tip>
    </div>
  </div>

  <div class="layui-form-item">
    <label class="layui-form-label required">规格</label>
    <div class="layui-input-block">
      <input type="text" name="norms" placeholder="请输入设备规格" value="" class="layui-input">
      <tip>填写规格</tip>
    </div>
  </div>

  <div class="layui-form-item">
    <label class="layui-form-label required">介绍</label>
    <div class="layui-input-block">
      <textarea name="intro" class="layui-textarea" placeholder="请输入介绍"></textarea>
    </div>
  </div>



  <div class="layui-form-item">
    <label class="layui-form-label required">状态</label>
    <div class="layui-input-block">
      <input type="text" name="status" lay-verify="required" lay-reqtext="状态不能为空" placeholder="请输入设备状态" value="" class="layui-input">
      <tip>填写状态</tip>
    </div>
  </div>

  <div class="layui-form-item">
    <label class="layui-form-label required">租用</label>
    <div class="layui-input-block">
      <input type="text" name="rent" lay-verify="required" lay-reqtext="租用不能为空" placeholder="请输入设备租用" value="" class="layui-input">
      <tip>填写租用</tip>
    </div>
  </div>

  <input type="hidden" name="f_name"  value="${user.fname}" >




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

    //监听提交
    form.on('submit(saveBtn)', function (data) {
      var datas= data.field;
      $.ajax({
        url:"deviceAddSubmit2",
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
</html>


