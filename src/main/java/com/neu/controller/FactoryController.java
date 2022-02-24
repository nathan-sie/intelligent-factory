package com.neu.controller;

import com.github.pagehelper.PageInfo;
import com.neu.po.Factory;
import com.neu.po.User;
import com.neu.service.FactoryService;
import com.neu.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;

@Controller
public class FactoryController {

    @Autowired
    private FactoryService factoryService;

    @GetMapping("/factoryIndex")
    public String factoryIndex(){
        return "/factory/factoryIndex";
    };

    @GetMapping("/factoryIndex2")
    public String factoryIndex2(){
        return "/factory/factoryIndex2";
    };

    @RequestMapping("/factoryAll")
    @ResponseBody
    public R factoryAll(String name, @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){

        PageInfo<Factory> pageInfo = factoryService.queryAllFactory(name,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/factoryA")
    @ResponseBody
    public R factoryAll(HttpServletRequest request, String uname, @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){
        User user = (User) request.getSession().getAttribute("user");
        PageInfo<Factory> pageInfo = factoryService.queryFactory(user.getName(), page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }


    @GetMapping("/queryFactoryById")
    public String queryFactoryById(Integer id, Model model){
        Factory factory = factoryService.queryFactoryById(id);
        model.addAttribute("factory",factory);
        return "/factory/factoryUpdate";
    }



    @ResponseBody
    @RequestMapping("/factoryDelete")
    public R factoryDelete(String ids){
        List list = Arrays.asList(ids.split(","));
        factoryService.deleteFactoryByIds(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/factoryOpen")
    public R factoryOpen(String ids){
        List list = Arrays.asList(ids.split(","));
        factoryService.openFactory(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/factoryClose")
    public R factoryClose(String ids){
        List list = Arrays.asList(ids.split(","));
        factoryService.closeFactory(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/findAllFactoryList")
    public List<Factory> findAll(){
        PageInfo<Factory> pageInfo=factoryService.queryAllFactory(null,1,100);
        List<Factory> lists=pageInfo.getList();
        return lists;
    }



}
