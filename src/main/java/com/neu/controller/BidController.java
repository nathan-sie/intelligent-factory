package com.neu.controller;

import com.github.pagehelper.PageInfo;
import com.neu.po.*;
import com.neu.service.BidService;
import com.neu.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;

@Controller
public class BidController {
    @Autowired
    private BidService bidService;

    @GetMapping("/bidIndex")
    public String bidIndex(){
        return "/bid/bidIndex";
    };

    @GetMapping("/bidIndex2")
    public String bidIndex2(){
        return "/bid/bidIndex2";
    };

    @GetMapping("/bidIndex3")
    public String bidIndex3(){
        return "/bid/bidIndex3";
    };

    @GetMapping("/bidIndex4")
    public String bidIndex4(){
        return "/bid/bidIndex4";
    };


    @RequestMapping("/bidAll")
    @ResponseBody
    public R bidAll(Integer status, @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){

        PageInfo<Bid> pageInfo = bidService.queryAllBid(status,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @RequestMapping("/bidA")
    @ResponseBody
    public R bidA(HttpServletRequest request,@RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){
        User user = (User) request.getSession().getAttribute("user");
        PageInfo<Bid> pageInfo = bidService.queryBid(user.getName(),page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }


    @RequestMapping("/bidD")
    @ResponseBody
    public R bidD(HttpServletRequest request,@RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){
        User user = (User) request.getSession().getAttribute("user");
        PageInfo<Bid> pageInfo = bidService.queryBid2(user.getName(),page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }


    @ResponseBody
    @RequestMapping("/bidS")
    public R capacityAll(HttpServletRequest request, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "5")Integer limit){
        Order order = (Order) request.getSession().getAttribute("order");
        PageInfo<Bid> pageInfo = bidService.queryBid3(order.getId(),page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @GetMapping("/bidAdd")
    public String bidAdd(){
        return "/bid/bidAdd";
    }


    @ResponseBody
    @RequestMapping("/bidAddSubmit")
    public R addBidSubmit(HttpServletRequest request, Bid bid){
        User user = (User) request.getSession().getAttribute("user");
        bidService.addBidSubmit(bid);
        return R.ok();

    }

    @ResponseBody
    @RequestMapping("/bidChoose")
    public R chooseBid(String ids){
        List list = Arrays.asList(ids.split(","));
        bidService.chooseBid(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/bidDeny")
    public R denyBid(String ids){
        List list = Arrays.asList(ids.split(","));
        bidService.denyBid(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/bidProduce")
    public R produceBid(String ids){
        List list = Arrays.asList(ids.split(","));
        bidService.productBid(list);
        return R.ok();
    }


}