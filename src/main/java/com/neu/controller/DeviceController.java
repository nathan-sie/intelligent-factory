package com.neu.controller;

import com.github.pagehelper.PageInfo;
import com.neu.po.Device;
import com.neu.po.DeviceType;
import com.neu.po.User;
import com.neu.service.DeviceService;
import com.neu.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;


@Controller
public class DeviceController {

    @Autowired
    private DeviceService deviceService;

    @GetMapping("/deviceIndex")
    public String deviceIndex(){
        return "/device/deviceIndex";
    };

    @GetMapping("/deviceIndex2")
    public String deviceIndex2(){
        return "/device/deviceIndex2";
    };

    @GetMapping("/deviceRent")
    public String deviceRent(){
        return "/device/deviceRent";
    };

    @GetMapping("/deviceRent2")
    public String deviceRent2(){
        return "/device/deviceRent2";
    };

    @ResponseBody
    @RequestMapping("/deviceAll")
    public R deviceAll(String name,Integer tid, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "5") Integer limit){
        PageInfo<Device> pageInfo = deviceService.queryAllDevice(name,tid,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @ResponseBody
    @RequestMapping("/deviceA")
    public R deviceA(HttpServletRequest request, String name, String f_name, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "5") Integer limit){
        User user = (User) request.getSession().getAttribute("user");
        PageInfo<Device> pageInfo = deviceService.queryDevice(name, user.getFname(), page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @ResponseBody
    @RequestMapping("/deviceR")
    public R deviceR(HttpServletRequest request, String name, String f_name,Integer rent, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "5") Integer limit){
        User user = (User) request.getSession().getAttribute("user");
        PageInfo<Device> pageInfo = deviceService.queryRentDevice(name, f_name,rent, page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @ResponseBody
    @RequestMapping("/deviceR2")
    public R deviceR2(HttpServletRequest request, String name, String f_name,Integer rent, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "5") Integer limit){
        User user = (User) request.getSession().getAttribute("user");
        PageInfo<Device> pageInfo = deviceService.queryRentDevice2(name, f_name,rent, page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @GetMapping("/rentAdd")
    public String deviceRentShow(Integer id, Model model){
        Device device = deviceService.queryDeviceById(id);
        model.addAttribute("device",device);
        return "/rent/rentAdd";}


    @GetMapping("/deviceAdd")
    public String deviceAdd(){
        return "/device/deviceAdd";
    }


    @GetMapping("/deviceAdd2")
    public String deviceAdd2(){
        return "/device/deviceAdd2";
    }

    @ResponseBody
    @RequestMapping("/deviceAddSubmit")
    public R addProdudctSubmit(Device device){
        deviceService.addDeviceSubmit(device);
        return R.ok();

    }

    @ResponseBody
    @RequestMapping("/deviceAddSubmit2")
    public R addProdudctSubmit2(HttpServletRequest request, Device device){
        User user = (User) request.getSession().getAttribute("user");
        deviceService.addDeviceSubmit(device);
        return R.ok();

    }


    @GetMapping("/queryDeviceById")
    public String queryDeviceById(Integer id, Model model){
        Device device = deviceService.queryDeviceById(id);
        model.addAttribute("device",device);
        return "/device/deviceUpdate";
    }

    @GetMapping("/queryDeviceById2")
    public String queryDeviceById2(Integer id, Model model){
        Device device = deviceService.queryDeviceById(id);
        model.addAttribute("device",device);
        return "/device/deviceUpdate2";
    }


    @GetMapping("/queryDeviceById3")
    public String queryDeviceById3( HttpServletRequest request, Model model,Integer id){
        Device device = deviceService.queryDeviceById(id);
        HttpSession session = request.getSession();
        session.setAttribute("device",device);
        model.addAttribute("device",device);
        return "capacity/capacityIndex";
    }


    @ResponseBody
    @RequestMapping("/deviceUpdateSubmit")
    public R updateDeviceSubmit(@RequestBody Device device){
        deviceService.updateDeviceSubmit(device);
        return R.ok();

    }

    @ResponseBody
    @RequestMapping("/deviceDelete")
    public R deviceDelete(String ids){
        List list = Arrays.asList(ids.split(","));
        deviceService.deleteDeviceByIds(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/deviceOpen")
    public R deviceOpen(String ids){
        List list = Arrays.asList(ids.split(","));
        deviceService.openDevice(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/deviceClose")
    public R deviceClose(String ids){
        List list = Arrays.asList(ids.split(","));
        deviceService.closeDevice(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/deviceRe")
    public R deviceRent(HttpServletRequest request,String ids){
        User user = (User) request.getSession().getAttribute("user");
        List list = Arrays.asList(ids.split(","));
        deviceService.rentDevice(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/deviceRe2")
    public R deviceRent2(HttpServletRequest request,String ids){
        User user = (User) request.getSession().getAttribute("user");
        List list = Arrays.asList(ids.split(","));
        deviceService.rentDevice2(user.getFname(),list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/deviceBa")
    public R deviceBa(HttpServletRequest request,String ids){
        User user = (User) request.getSession().getAttribute("user");
        List list = Arrays.asList(ids.split(","));
        deviceService.backDevice(list);
        return R.ok();
    }

}
