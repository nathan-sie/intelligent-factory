package com.neu.dao;


import com.neu.po.Factory;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("FactoryMapper")
public interface FactoryMapper {
    List<Factory> queryAllFactory(@Param(value = "name") String name);

    List<Factory> queryFactory(@Param(value = "uname") String uname);

    //增加
    void addFactorySubmit(Factory factory);

    //修改
    Factory queryFactoryById(Integer id);

    void updateFactorySubmit(Factory factory);

    void deleteFactoryByIds(List<Integer> id);

    void openFactory(List<Integer> id);

    void closeFactory(List<Integer> id);

}
