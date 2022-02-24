package com.neu.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neu.dao.ProductMapper;
import com.neu.po.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("ProductService")
public class ProductServiceImpl implements ProductService{

    @Autowired
    private ProductMapper productMapper;

    @Override
    public PageInfo<Product> queryAllProduct(String name, Integer tid, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Product> list = productMapper.queryAllProduct(name,tid);
        PageInfo<Product> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public void addProductSubmit(Product product) {
        productMapper.addProductSubmit(product);
    }

    @Override
    public Product queryProductById(Integer id) {

        return productMapper.queryProductById(id) ;
    }

    @Override
    public void updateProductSubmit(Product product) {
        productMapper.updateProductSubmit(product);
    }

    @Override
    public void updateProductSubmit2(Product product) {
        productMapper.updateProductSubmit2(product);
    }

    @Override
    public void deleteProductByIds(List<String> id) {
        List<Integer> list = new ArrayList<>();
        for (String cid : id) {
            int id2 = Integer.valueOf(cid);
            list.add(id2);
        }
        productMapper.deleteProductByIds(list);
    }
}
