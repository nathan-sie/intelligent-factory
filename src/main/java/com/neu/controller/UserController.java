package com.neu.controller;

import com.github.pagehelper.PageInfo;
import com.neu.po.User;
import com.neu.service.UserService;
import com.neu.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/userIndex")
    public String userIndex(){
        return "/user/userIndex";
    };

    @RequestMapping("/userAll")
    @ResponseBody
    public R userAll(String name, @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){

        PageInfo<User> pageInfo = userService.queryAllUser(name,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @GetMapping("/userAdd")
    public String userAdd(){
        return "/user/userAdd";
    }

    @ResponseBody
    @RequestMapping("/userAddSubmit")
    public R addProdudctTypeSubmit(User user){
        userService.addUserSubmit(user);
        return R.ok();

    }

    @ResponseBody
    @RequestMapping("/factoryAddSubmit")
    public R addFactorySubmit(User user){
        userService.addFactorySubmit(user);
        return  R.ok();
    }


    @GetMapping("/queryUserById")
    public String queryUserById(Integer id, Model model){
        User user = userService.queryUserById(id);
        model.addAttribute("user",user);
        return "/user/userUpdate";
    }

    @ResponseBody
    @RequestMapping("/userUpdateSubmit")
    public R updateUserSubmit(@RequestBody User user){
        userService.updateUserSubmit(user);
        return R.ok();

    }

    @ResponseBody
    @RequestMapping("/userDelete")
    public R userDelete(String ids){
        List list = Arrays.asList(ids.split(","));
        userService.deleteUserByIds(list);
        return R.ok();
    }

}
