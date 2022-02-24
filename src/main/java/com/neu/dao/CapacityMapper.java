package com.neu.dao;

import com.neu.po.Capacity;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("CapacityMapper")
public interface CapacityMapper {

    List<Capacity>  queryAllCapacity(@Param(value = "did") Integer did);

    void addCapacitySubmit(Capacity capacity);

    Capacity queryCapacityById(Integer id);

    void updateCapacitySubmit(Capacity capacity);

    void deleteCapacityByIds(List<Integer> id);
}
