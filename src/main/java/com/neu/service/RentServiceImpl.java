package com.neu.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neu.dao.RentMapper;
import com.neu.po.Rent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("RentService")
public class RentServiceImpl implements RentService{

    @Autowired
    private RentMapper rentMapper;

    @Override
    public PageInfo<Rent> queryAllRent(String f_name, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Rent> list =rentMapper.queryAllRent(f_name);
        PageInfo<Rent>  pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public void addRentSubmit(Rent rent) {
        rentMapper.addRentSubmit(rent);
    }
}
