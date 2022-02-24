package com.neu.dao;

import com.neu.po.Rent;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("RentMapper")
public interface RentMapper {

    List<Rent> queryAllRent(@Param(value = "f_name") String f_name);

    void addRentSubmit(Rent rent);
}
