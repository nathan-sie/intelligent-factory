package com.neu.service;

import com.github.pagehelper.PageInfo;
import com.neu.po.Rent;

public interface RentService {

    public PageInfo<Rent> queryAllRent(String f_name,int page,int limit);

    void addRentSubmit(Rent rent);
}
