package com.neu.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neu.dao.DeviceMapper;
import com.neu.po.Device;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("DeviceService")
public class DeviceServiceImpl implements DeviceService{

    @Autowired
    private DeviceMapper deviceMapper;

    @Override
    public PageInfo<Device> queryAllDevice(String name,Integer tid,int page, int limit) {
        //传入参数，每页条数 当前页
        PageHelper.startPage(page,limit);
        List<Device> list = deviceMapper.queryAllDevice(name,tid);
        //通过包装获取分页需要的其他值信息
        PageInfo<Device> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<Device> queryDevice(String name,String f_name,int page, int limit) {
        //传入参数，每页条数 当前页
        PageHelper.startPage(page,limit);
        List<Device> list = deviceMapper.queryDevice(name,f_name);
        //通过包装获取分页需要的其他值信息
        PageInfo<Device> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<Device> queryRentDevice(String name,String f_name,Integer rent,int page, int limit) {
        //传入参数，每页条数 当前页
        PageHelper.startPage(page,limit);
        List<Device> list = deviceMapper.queryRentDevice(name,f_name,rent);
        //通过包装获取分页需要的其他值信息
        PageInfo<Device> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    public PageInfo<Device> queryRentDevice2(String name,String f_name,Integer rent,int page, int limit) {
        //传入参数，每页条数 当前页
        PageHelper.startPage(page,limit);
        List<Device> list = deviceMapper.queryRentDevice2(name,f_name,rent);
        //通过包装获取分页需要的其他值信息
        PageInfo<Device> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }



    @Override
    public void addDeviceSubmit(Device device) {
        deviceMapper.addDeviceSubmit(device);
    }

    @Override
    public Device queryDeviceById(Integer id) {
        return deviceMapper.queryDeviceById(id);
    }

    @Override
    public void updateDeviceSubmit(Device device) {
        deviceMapper.updateDeviceSubmit(device);
    }

    @Override
    public void deleteDeviceByIds(List<String> id) {
        List<Integer> list = new ArrayList<>();
        for (String cid : id) {
            int id2 = Integer.valueOf(cid);
            list.add(id2);
        }
        deviceMapper.deleteDeviceByIds(list);

    }

    @Override
    public void openDevice(List<Integer> id) {
        deviceMapper.openDevice(id);
    }

    @Override
    public void closeDevice(List<Integer> id) {
        deviceMapper.closeDevice(id);
    }

    @Override
    public void rentDevice( List<Integer> id) {
        deviceMapper.rentDevice(id);
    }

    @Override
    public void rentDevice2(String f_name, List<Integer> id) {
        deviceMapper.rentDevice2(f_name,id);
    }

    @Override
    public void backDevice( List<Integer> id) {
        deviceMapper.backDevice(id);
    }

}