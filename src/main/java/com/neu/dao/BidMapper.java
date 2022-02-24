package com.neu.dao;

import com.neu.po.Bid;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

@Component("BidMapper")
public interface BidMapper {
    List<Bid> queryAllBid(@Param(value = "status") Integer status);

    List<Bid> queryBid(@Param(value = "uname") String uname);

    List<Bid> queryBid2(@Param(value = "name") String name);

    List<Bid> queryBid3(@Param(value = "oid") Integer oid);

    void addBid(Bid bid);

    void chooseBid(List<Integer> id);

    void denyBid(List<Integer> id);

    void productBid(List<Integer> id);
}
