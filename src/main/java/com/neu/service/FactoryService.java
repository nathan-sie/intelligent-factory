package com.neu.service;

import com.github.pagehelper.PageInfo;
import com.neu.po.Factory;

import java.util.List;

public interface FactoryService {
    public PageInfo<Factory> queryAllFactory(String name, int page, int limit);

    public PageInfo<Factory> queryFactory(String uname, int page, int limit);

    //增加
    void addFactorySubmit(Factory factory);

    //修改
    Factory queryFactoryById(Integer id);

    void updateFactorySubmit(Factory factory);

    void deleteFactoryByIds(List<String> id);

    void openFactory(List<Integer> id);

    void closeFactory(List<Integer> id);

}
