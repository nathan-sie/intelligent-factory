package com.neu.controller;

import com.github.pagehelper.PageInfo;
import com.neu.po.Capacity;
import com.neu.po.Device;
import com.neu.po.User;
import com.neu.service.CapacityService;
import com.neu.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;

@Controller
public class CapacityController {

    @Autowired
    private CapacityService capacityService;

    @GetMapping("/capacityIndex")
    public String capacityIndex(){
        return "/capacity/capacityIndex";
    };

    @GetMapping("/capacityAdd")
    public String capacityAdd(){
        return "/capacity/capacityAdd";
    }

    @ResponseBody
    @RequestMapping("/capacityAll")
    public R capacityAll(HttpServletRequest request, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "5")Integer limit){
        Device device = (Device) request.getSession().getAttribute("device");
        PageInfo<Capacity> pageInfo =capacityService.queryAllCapacity(device.getId(),page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @ResponseBody
    @RequestMapping("/capacityAddSubmit")
    public R addCapacitySubmit(Capacity capacity){
        capacityService.addCapacitySubmit(capacity);
        return R.ok();
    }

    @GetMapping("/queryCapacityById")
    public String queryCapacityById(Integer id, Model model){
        Capacity capacity = capacityService.queryCapacityById(id);
        model.addAttribute("capacity",capacity);
        return "/capacity/capacityUpdate";
    }

    @ResponseBody
    @RequestMapping("/capacityUpdateSubmit")
    public R updateCapacitySubmit(@RequestBody Capacity capacity){
        capacityService.updateCapacitySubmit(capacity);
        return R.ok();

    }

    @ResponseBody
    @RequestMapping("/capacityDelete")
    public R capacityDelete(String ids){
        List list = Arrays.asList(ids.split(","));
        capacityService.deleteCapacityByIds(list);
        return R.ok();
    }


}
