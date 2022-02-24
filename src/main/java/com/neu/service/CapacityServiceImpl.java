package com.neu.service;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neu.dao.CapacityMapper;
import com.neu.po.Capacity;
import com.neu.po.Device;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("CapacityService")
public class CapacityServiceImpl implements CapacityService {

    @Autowired
    private CapacityMapper capacityMapper;

    @Override
    public PageInfo<Capacity> queryAllCapacity(Integer did,int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Capacity> list = capacityMapper.queryAllCapacity(did);
        PageInfo<Capacity> pageInfo = new PageInfo<>(list);
        return pageInfo;

    }

    @Override
    public void addCapacitySubmit(Capacity capacity) {
        capacityMapper.addCapacitySubmit(capacity);
    }

    @Override
    public Capacity queryCapacityById(Integer id) {
        return capacityMapper.queryCapacityById(id);
    }

    @Override
    public void updateCapacitySubmit(Capacity capacity) {
        capacityMapper.updateCapacitySubmit(capacity);
    }

    @Override
    public void deleteCapacityByIds(List<String> id) {
        List<Integer> list = new ArrayList<>();
        for (String cid : id) {
            int id2 = Integer.valueOf(cid);
            list.add(id2);
        }
        capacityMapper.deleteCapacityByIds(list);

    }
}
