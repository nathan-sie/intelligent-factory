package com.neu.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neu.dao.DeviceTypeMapper;
import com.neu.po.DeviceType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("DeviceTypeService")
public class DeviceTypeServiceImpl implements DeviceTypeService{

    @Autowired
    private DeviceTypeMapper deviceTypeMapper;

    @Override

    public PageInfo<DeviceType> queryAllDeviceType(String name, int page, int limit) {
        //传入参数，每页条数 当前页
        PageHelper.startPage(page,limit);
        List<DeviceType> list = deviceTypeMapper.queryAllDeviceType(name);
        //通过包装获取分页需要的其他值信息
        PageInfo<DeviceType> pageInfo = new PageInfo<>(list);
        return pageInfo;


    }

    @Override
    public void addDeviceTypeSubmit(DeviceType deviceType) {
        deviceTypeMapper.addDeviceTypeSubmit(deviceType);
    }

    @Override
    public DeviceType queryDeviceTypeById(Integer id) {
        return deviceTypeMapper.queryDeviceTypeById(id);
    }

    @Override
    public void updateDeviceTypeSubmit(DeviceType deviceType) {
        deviceTypeMapper.updateDeviceTypeSubmit(deviceType);
    }

    @Override
    public void deleteDeviceTypeByIds(List<String> id) {
        List<Integer> list=new ArrayList<>();
        for(String cid:id){
            int id2= Integer.valueOf(cid);
            list.add(id2);
        }
        deviceTypeMapper.deleteDeviceTypeByIds(list);


    }
}
