package com.neu.service;

import com.github.pagehelper.PageInfo;
import com.neu.po.Capacity;

import java.util.List;

public interface CapacityService {
    PageInfo<Capacity> queryAllCapacity(Integer did,int page, int limit);

    void addCapacitySubmit(Capacity capacity);

    Capacity queryCapacityById(Integer id);


    void updateCapacitySubmit(Capacity capacity);

    void deleteCapacityByIds(List<String> id);
}
