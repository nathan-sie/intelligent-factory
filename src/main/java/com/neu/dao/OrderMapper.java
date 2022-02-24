package com.neu.dao;


import com.neu.po.Order;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("OrderMapper")
public interface OrderMapper {
    List<Order> queryAllOrder(@Param(value = "status") Integer status);

    List<Order> queryOrder(@Param(value = "receiver") String receiver,@Param(value = "status") Integer status);

    List<Order> showOrder(@Param(value = "status") Integer status);

    List<Order> showOrder2(@Param(value = "status") Integer status);

    void addOrder(Order order);

    Order queryOrderById(Integer id);

    void updateOrder(Order order);

    void deleteOrderByIds(List<Integer> id);

    void issueOrder(List<Integer> id);

    void receiveOrder(List<Integer> id);

    void chooseOrder(List<Integer> id);

    void chooseOrder2(List<Integer> id);

    void releaseOrder(List<Integer> id);
}
