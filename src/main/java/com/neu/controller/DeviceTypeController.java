package com.neu.controller;

import com.github.pagehelper.PageInfo;
import com.neu.po.DeviceType;
import com.neu.service.DeviceTypeService;
import com.neu.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller
public class DeviceTypeController {

    @Autowired
    private DeviceTypeService deviceTypeService;

    @GetMapping("/deviceTypeIndex")
    public String deviceTypeIndex(){
        return "/deviceType/deviceTypeIndex";
    };

    @RequestMapping("/deviceTypeAll")
    @ResponseBody
    public R deviceTypeAll(String name, @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){

        PageInfo<DeviceType> pageInfo = deviceTypeService.queryAllDeviceType(name,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @GetMapping("/deviceTypeAdd")
    public String deviceTypeAdd(){
        return "/deviceType/deviceTypeAdd";
    }

    @ResponseBody
    @RequestMapping("/deviceTypeAddSubmit")
    public R addProdudctTypeSubmit(DeviceType deviceType){
        deviceTypeService.addDeviceTypeSubmit(deviceType);
        return R.ok();

    }

    @GetMapping("/queryDeviceTypeById")
    public String queryDeviceTypeById(Integer id, Model model){
        DeviceType deviceType = deviceTypeService.queryDeviceTypeById(id);
        model.addAttribute("deviceType",deviceType);
        return "/deviceType/deviceTypeUpdate";
    }

    @ResponseBody
    @RequestMapping("/deviceTypeUpdateSubmit")
    public R updateProdudctTypeSubmit(@RequestBody DeviceType deviceType){
        deviceTypeService.updateDeviceTypeSubmit(deviceType);
        return R.ok();

    }

    @ResponseBody
    @RequestMapping("/deviceTypeDelete")
    public R deviceTypeDelete(String ids){
        List list = Arrays.asList(ids.split(","));
        deviceTypeService.deleteDeviceTypeByIds(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/findAllDeviceList")
    public List<DeviceType> findAll(){
        PageInfo<DeviceType> pageInfo=deviceTypeService.queryAllDeviceType(null,1,100);
        List<DeviceType> lists=pageInfo.getList();
        return lists;
    }

}
