package com.neu.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neu.dao.BidMapper;
import com.neu.po.Bid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("BidService")
public class BidServiceImpl implements BidService{
    @Autowired
    private BidMapper bidMapper;

    @Override
    public PageInfo<Bid> queryAllBid(Integer status, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Bid> list = bidMapper.queryAllBid(status);
        PageInfo<Bid> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<Bid> queryBid(String uname,int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Bid> list = bidMapper.queryBid(uname);
        PageInfo<Bid> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<Bid> queryBid2(String name,int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Bid> list = bidMapper.queryBid2(name);
        PageInfo<Bid> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public PageInfo<Bid> queryBid3(Integer oid, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Bid> list = bidMapper.queryBid3(oid);
        PageInfo<Bid> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public void addBidSubmit(Bid bid) {
        bidMapper.addBid(bid);
    }

    @Override
    public void chooseBid(List<Integer> id) {
        bidMapper.chooseBid(id);
    }

    @Override
    public void denyBid(List<Integer> id) {
        bidMapper.denyBid(id);
    }

    @Override
    public void productBid(List<Integer> id) {
        bidMapper.productBid(id);
    }
}
