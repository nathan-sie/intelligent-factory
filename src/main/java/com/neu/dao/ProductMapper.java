package com.neu.dao;

import com.neu.po.Product;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("ProductMapper")
public interface ProductMapper {
    List<Product> queryAllProduct(@Param(value = "name") String name, @Param(value = "tid") Integer tid);

    //增加
    void addProductSubmit(Product product);

    //修改
    Product queryProductById(Integer id);

    void updateProductSubmit(Product product);

    void updateProductSubmit2(Product product);

    void deleteProductByIds(List<Integer> id);
}
