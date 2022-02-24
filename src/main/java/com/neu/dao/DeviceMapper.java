package com.neu.dao;

import com.github.pagehelper.PageInfo;
import com.neu.po.Device;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("DeviceMapper")
public interface DeviceMapper {



    List<Device> queryAllDevice(@Param(value = "name") String name,@Param(value = "tid") Integer tid);
    List<Device> queryDevice(@Param(value = "name") String name,@Param(value = "f_name") String f_name);
    List<Device> queryRentDevice(@Param(value = "name") String name,@Param(value = "f_name") String f_name,@Param(value = "rent") Integer rent);

    List<Device> queryRentDevice2(@Param(value = "name") String name,@Param(value = "f_name") String f_name,@Param(value = "rent") Integer rent);

    //增加
    void addDeviceSubmit(Device device);

    //修改
    Device queryDeviceById(Integer id);

    //
    void updateDeviceSubmit(Device device);

    void deleteDeviceByIds(List<Integer> id);

    void openDevice(List<Integer> id);

    void closeDevice(List<Integer> id);

    void rentDevice(List<Integer> id);

    void rentDevice2(@Param(value = "f_name") String f_name,List<Integer> id);

    void backDevice(List<Integer> id);


}

