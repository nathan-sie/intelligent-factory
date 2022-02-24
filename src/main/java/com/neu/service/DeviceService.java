package com.neu.service;

import com.github.pagehelper.PageInfo;
import com.neu.po.Device;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeviceService {

    PageInfo<Device> queryAllDevice(String name,Integer tid, int page, int limit);

    PageInfo<Device> queryDevice(String name,String f_name,int page, int limit);

    PageInfo<Device> queryRentDevice(String name,String f_name,Integer rent,int page, int limit);

    PageInfo<Device> queryRentDevice2(String name,String f_name,Integer rent,int page, int limit);
    //增加
    void addDeviceSubmit(Device device);

    //修改
    Device queryDeviceById(Integer id);

    void updateDeviceSubmit(Device device);

    void deleteDeviceByIds(List<String> id);

    void openDevice(List<Integer> id);

    void closeDevice(List<Integer> id);

    void rentDevice(List<Integer> id);

    void rentDevice2(String f_name,List<Integer> id);

    void backDevice(List<Integer> id);
}
