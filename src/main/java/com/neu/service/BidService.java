package com.neu.service;

import com.github.pagehelper.PageInfo;
import com.neu.po.Bid;
import com.sun.org.apache.xpath.internal.axes.SelfIteratorNoPredicate;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BidService {
    public PageInfo<Bid> queryAllBid(Integer status, int page, int limit);

    public PageInfo<Bid> queryBid(String uname, int page, int limit);

    public PageInfo<Bid> queryBid2(String name, int page, int limit);

    public PageInfo<Bid> queryBid3(Integer oid, int page, int limit);

    void addBidSubmit(Bid bid);


    void chooseBid(List<Integer> id);

    void denyBid(List<Integer> id);

    void productBid(List<Integer> id);

}
