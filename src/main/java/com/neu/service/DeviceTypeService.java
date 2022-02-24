package com.neu.service;

import com.github.pagehelper.PageInfo;
import com.neu.po.DeviceType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeviceTypeService {

    public PageInfo<DeviceType> queryAllDeviceType(String name, int page, int limit);

    //增加
    void addDeviceTypeSubmit(DeviceType deviceType);

    //修改
    DeviceType queryDeviceTypeById(Integer id);

    void updateDeviceTypeSubmit(DeviceType deviceType);

    void deleteDeviceTypeByIds(List<String> id);

}
