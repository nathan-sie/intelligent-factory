package com.neu.service;

import com.github.pagehelper.PageInfo;
import com.neu.po.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductService {

    PageInfo<Product> queryAllProduct(String name, Integer tid, int page, int limit);


    //增加
    void addProductSubmit(Product product);

    //修改
    Product queryProductById(Integer id);


    void updateProductSubmit(Product product);

    void updateProductSubmit2(Product product);

    void deleteProductByIds(List<String> id);
}
