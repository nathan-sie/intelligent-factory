package com.neu.controller;

import com.github.pagehelper.PageInfo;
import com.neu.po.Order;
import com.neu.po.Schedule;
import com.neu.po.User;
import com.neu.service.ScheduleService;
import com.neu.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;

@Controller
public class ScheduleController {
    @Autowired
    private ScheduleService scheduleService;

    @GetMapping("/scheduleIndex")
    public String scheduleIndex(){
        return "/schedule/scheduleIndex";
    };

    @GetMapping("/scheduleAdd")
    public String scheduleAdd(){
        return "/schedule/scheduleAdd";
    }

    @ResponseBody
    @RequestMapping("/scheduleAll")
    public R scheduleAll(HttpServletRequest request, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "5")Integer limit){
        Order order = (Order) request.getSession().getAttribute("order");
        PageInfo<Schedule> pageInfo =scheduleService.queryAllSchedule(order.getId(),page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }


    @ResponseBody
    @RequestMapping("/scheduleAddSubmit")
    public R addScheduleSubmit(HttpServletRequest request, Schedule schedule){
        User user = (User) request.getSession().getAttribute("user");
        scheduleService.addScheduleSubmit(schedule);
        return  R.ok();
    }

    @GetMapping("/queryScheduleById")
    public String queryScheduleById(Integer id, Model model){
        Schedule schedule = scheduleService.queryScheduleById(id);
        model.addAttribute("schedule",schedule);
        return "/schedule/scheduleUpdate";
    }

    @ResponseBody
    @RequestMapping("/scheduleUpdateSubmit")
    public R updateScheduleSubmit(Schedule schedule){
        scheduleService.updateScheduleSubmit(schedule);
        return R.ok();

    }

    @ResponseBody
    @RequestMapping("/scheduleDelete")
    public R scheduleDelete(String ids){
        List list = Arrays.asList(ids.split(","));
        scheduleService.deleteScheduleByIds(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/orderProduce")
    public R orderChoose(String ids){
        List list = Arrays.asList(ids.split(","));
        scheduleService.produceOrder(list);
        return  R.ok();
    }




}
