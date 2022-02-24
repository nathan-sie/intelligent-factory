<%--
  Created by IntelliJ IDEA.
  User: nate
  Date: 2021/7/18
  Time: 15:32
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
  <input type="hidden" name="id"  value="${product.id}" >

  <div class="layui-form-item">
    <label class="layui-form-label required">产品名称</label>
    <div class="layui-input-block">
      <input type="text" name="name" lay-verify="required"  value="${product.name}" class="layui-input">
      <tip>修改产品名称</tip>
    </div>
  </div>



  <div class="layui-form-item">
    <label class="layui-form-label required">编号</label>
    <div class="layui-input-block">
      <input type="text" name="pno" lay-verify="required"   value="${product.pno}" class="layui-input">
      <tip>修改产品编号</tip>
    </div>
  </div>

  <div class="layui-form-item">
    <label class="layui-form-label required">规格</label>
    <div class="layui-input-block">
      <input type="text" name="norms"  value="${product.norms}" class="layui-input">
      <tip>修改规格</tip>
    </div>
  </div>

  <div class="layui-form-item">
    <label class="layui-form-label required">介绍</label>
    <div class="layui-input-block">
      <textarea name="intro" class="layui-textarea">${product.intro}</textarea>
    </div>
  </div>

  <input type="hidden" name="tid"  value="${product.tid}" >








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

    $.get("findAllProductList",{},function (data) {
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
        url:"productUpdateSubmit",
        type:"POST",
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
