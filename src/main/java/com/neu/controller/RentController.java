package com.neu.controller;

import com.github.pagehelper.PageInfo;
import com.neu.po.Rent;
import com.neu.po.User;
import com.neu.service.RentService;
import com.neu.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class RentController {

    @Autowired
    private RentService rentService;

    @GetMapping("/rentIndex")
    public String rentIndex(){
        return "/rent/rentIndex";
    };

    @RequestMapping("/rentAll")
    @ResponseBody
    public R rentAll(String f_name, @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){

        PageInfo<Rent> pageInfo = rentService.queryAllRent(f_name,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @ResponseBody
    @RequestMapping("/rentAddSubmit")
    public R addRentSubmit(HttpServletRequest request, Rent rent){
        User user = (User) request.getSession().getAttribute("user");
        rentService.addRentSubmit(rent);
        return R.ok();
    }



}
