package com.neu.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neu.dao.OrderMapper;
import com.neu.po.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("OrderService")
public class OrderServiceImpl implements OrderService{

    @Autowired
    private OrderMapper orderMapper;
    @Override
    public PageInfo<Order> queryAllOrder(Integer status, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Order> list = orderMapper.queryAllOrder(status);
        PageInfo<Order> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<Order> queryOrder(String receiver,Integer status, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Order> list = orderMapper.queryOrder(receiver,status);
        PageInfo<Order> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<Order> showOrder(Integer status,int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Order> list = orderMapper.showOrder(status);
        PageInfo<Order> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<Order> showOrder2(Integer status,int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Order> list = orderMapper.showOrder2(status);
        PageInfo<Order> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public void addOrder(Order order) {
        orderMapper.addOrder(order);
    }

    @Override
    public Order queryOrderById(Integer id) {
        return orderMapper.queryOrderById(id);
    }

    @Override
    public void updateOrder(Order order) {
        orderMapper.updateOrder(order);
    }

    @Override
    public void deleteOrderByIds(List<String> id) {
        List<Integer> list=new ArrayList<>();
        for(String cid:id){
            int id2= Integer.valueOf(cid);
            list.add(id2);
        }
        orderMapper.deleteOrderByIds(list);
    }

    @Override
    public void issueOrder(List<Integer> id) {
        orderMapper.issueOrder(id);
    }

    @Override
    public void receiveOrder(List<Integer> id) {
        orderMapper.receiveOrder(id);
    }

    @Override
    public void chooseOrder(List<Integer> id) {
        orderMapper.chooseOrder(id);
    }

    @Override
    public void chooseOrder2(List<Integer> id) {
        orderMapper.chooseOrder2(id);
    }

    @Override
    public void releaseOrder(List<Integer> id) {
        orderMapper.releaseOrder(id);
    }
}
