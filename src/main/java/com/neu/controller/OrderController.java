package com.neu.controller;

import com.github.pagehelper.PageInfo;
import com.neu.po.Order;
import com.neu.po.User;
import com.neu.service.OrderService;
import com.neu.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

@Controller
public class OrderController {
    @Autowired
    private OrderService orderService;

    @GetMapping("/orderIndex")
    public String orderIndex(){
        return "/order/orderIndex";
    };

    @GetMapping("/orderIndex2")
    public String orderIndex2(){
        return "/order/orderIndex2";
    };

    @GetMapping("/orderIndex3")
    public String orderIndex3(){
        return "/order/orderIndex3";
    };


    @GetMapping("/orderIndex4")
    public String orderIndex4(){
        return "/order/orderIndex4";
    };

    @RequestMapping("/orderAll")
    @ResponseBody
    public R orderAll(Integer status, @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){

        PageInfo<Order> pageInfo = orderService.queryAllOrder(status,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/orderA")
    @ResponseBody
    public R orderA(HttpServletRequest request, Integer status,@RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){
        User user = (User) request.getSession().getAttribute("user");
        PageInfo<Order> pageInfo = orderService.queryOrder(user.getName(),status,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/orderS")
    @ResponseBody
    public R orderShow(Integer status, @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){

        PageInfo<Order> pageInfo = orderService.showOrder(status,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/orderS2")
    @ResponseBody
    public R orderShow2(Integer status, @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){

        PageInfo<Order> pageInfo = orderService.showOrder2(status,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @GetMapping("/orderAdd")
    public String orderAdd(){
        return "order/orderAdd";
    }

    @RequestMapping("/orderAddSubmit")
    @ResponseBody
    public R orderAddSubmit(Order order){
        orderService.addOrder(order);
        return R.ok();
    }

    @GetMapping("/queryOrderById")
    public String queryOrderById(Integer id,Model model){
        Order order = orderService.queryOrderById(id);
        model.addAttribute("order",order);
        return "order/orderUpdate";
    }

    @GetMapping("/queryOrderById2")
    public String queryOrderById2(Integer id,Model model){
        Order order = orderService.queryOrderById(id);
        model.addAttribute("order",order);
        return "bid/bidAdd";
    }

    @GetMapping("/queryOrderById3")
    public String queryOrderById3(Integer id,HttpServletRequest request, Model model){
        Order order = orderService.queryOrderById(id);
        HttpSession session = request.getSession();
        session.setAttribute("order",order);
        model.addAttribute("order",order);
        return "schedule/scheduleIndex";
    }

    @GetMapping("/queryOrderById4")
    public String queryOrderById4(Integer id,HttpServletRequest request, Model model){
        Order order = orderService.queryOrderById(id);
        HttpSession session = request.getSession();
        session.setAttribute("order",order);
        model.addAttribute("order",order);
        return "bid/bidIndex4";
    }

    @ResponseBody
    @RequestMapping("/orderUpdateSubmit")
    public R orderUpdateSubmit(@RequestBody Order order){
        orderService.updateOrder(order);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/orderDelete")
    public R orderDelete(String ids){
        List list = Arrays.asList(ids.split(","));
        orderService.deleteOrderByIds(list);
        return  R.ok();
    }

    @ResponseBody
    @RequestMapping("/orderIssue")
    public R orderIssue(String ids){
        List list = Arrays.asList(ids.split(","));
        orderService.issueOrder(list);
        return  R.ok();
    }

    @ResponseBody
    @RequestMapping("/orderReceive")
    public R orderReceive(String ids){
        List list = Arrays.asList(ids.split(","));
        orderService.receiveOrder(list);
        return  R.ok();
    }

    @ResponseBody
    @RequestMapping("/orderChoose")
    public R orderChoose(HttpServletRequest request,String ids){

        List list = Arrays.asList(ids.split(","));
        orderService.chooseOrder(list);
        return  R.ok();
    }

    @ResponseBody
    @RequestMapping("/orderChoose2")
    public R orderChoose2(HttpServletRequest request,String ids){

        List list = Arrays.asList(ids.split(","));
        orderService.chooseOrder2(list);
        return  R.ok();
    }

    @ResponseBody
    @RequestMapping("/orderRelease")
    public R releaseChoose(HttpServletRequest request,String ids){

        List list = Arrays.asList(ids.split(","));
        orderService.releaseOrder(list);
        return  R.ok();
    }

}
