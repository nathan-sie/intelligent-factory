package com.neu.service;

import com.github.pagehelper.PageInfo;
import com.neu.po.ProductType;

import java.util.List;

public interface ProductTypeService {

   public PageInfo<ProductType> queryAllProductType(String name,int page,int limit);

   //增加
   void addProdudctTypeSubmit(ProductType productType);

   //修改
   ProductType queryProductTypeById(Integer id);

   void updateProductTypeSubmit(ProductType productType);

   void deleteProductTypeByIds(List<String> id);

}
