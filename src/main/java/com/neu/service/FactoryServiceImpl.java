package com.neu.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neu.dao.FactoryMapper;
import com.neu.po.Factory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("FactoryService")
public class FactoryServiceImpl implements FactoryService{

    @Autowired
    private FactoryMapper factoryMapper;

    @Override
    public PageInfo<Factory> queryAllFactory(String name, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Factory> list = factoryMapper.queryAllFactory(name);
        PageInfo<Factory> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<Factory> queryFactory(String uname, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Factory> list = factoryMapper.queryFactory(uname);
        PageInfo<Factory> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public void addFactorySubmit(Factory factory) {
        factoryMapper.addFactorySubmit(factory);
    }

    @Override
    public Factory queryFactoryById(Integer id) {

        return factoryMapper.queryFactoryById(id);
    }

    @Override
    public void updateFactorySubmit(Factory factory) {
        factoryMapper.updateFactorySubmit(factory);
    }

    @Override
    public void deleteFactoryByIds(List<String> id) {
        List<Integer> list=new ArrayList<>();
        for(String cid:id){
            int id2= Integer.valueOf(cid);
            list.add(id2);
        }
        factoryMapper.deleteFactoryByIds(list);
    }

    @Override
    public void openFactory(List<Integer> id) {
        factoryMapper.openFactory(id);
    }

    @Override
    public void closeFactory(List<Integer> id) {
        factoryMapper.closeFactory(id);
    }
}
