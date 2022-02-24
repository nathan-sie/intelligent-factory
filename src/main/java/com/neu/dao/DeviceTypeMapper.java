package com.neu.dao;

import com.neu.po.DeviceType;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("DeviceTypeMapper")
public interface DeviceTypeMapper {

    List<DeviceType> queryAllDeviceType(@Param(value = "name") String name);

    //增加
    void addDeviceTypeSubmit(DeviceType deviceType);

    //修改
    DeviceType queryDeviceTypeById(Integer id);

    void updateDeviceTypeSubmit(DeviceType deviceType);

    void deleteDeviceTypeByIds(List<Integer> id);
}
