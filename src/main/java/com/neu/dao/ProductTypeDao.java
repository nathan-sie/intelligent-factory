package com.neu.dao;

import com.neu.po.ProductType;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("ProductTypeDao")
public interface ProductTypeDao {

   // @Select("select * from module_product_type_tab")

    List<ProductType> queryAllProductType(@Param(value = "name") String name);

    //增加
    void addProdudctTypeSubmit(ProductType productType);

    //修改
    ProductType queryProductTypeById(Integer id);

    void updateProductTypeSubmit(ProductType productType);

    void deleteProductTypeByIds(List<Integer> id);

}
