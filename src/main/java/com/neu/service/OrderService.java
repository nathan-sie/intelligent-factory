package com.neu.service;

import com.github.pagehelper.PageInfo;
import com.neu.po.Order;

import java.util.List;

public interface OrderService {
    public PageInfo<Order> queryAllOrder(Integer status, int page, int limit);

    public PageInfo<Order> queryOrder(String receiver, Integer status,int page, int limit);

    public PageInfo<Order> showOrder(Integer status,int page,int limit);

    public PageInfo<Order> showOrder2(Integer status,int page,int limit);

    void addOrder(Order order);

    Order queryOrderById(Integer id);

    void updateOrder(Order order);

    void deleteOrderByIds(List<String> id);

    void issueOrder(List<Integer> id);

    void receiveOrder(List<Integer> id);

    void chooseOrder(List<Integer> id);

    void chooseOrder2(List<Integer> id);

    void releaseOrder(List<Integer> id);
}
