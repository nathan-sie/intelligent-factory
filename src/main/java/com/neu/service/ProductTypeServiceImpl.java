package com.neu.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neu.dao.ProductTypeDao;
import com.neu.po.ProductType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("productTypeService")
public class ProductTypeServiceImpl implements ProductTypeService {

    @Autowired
    private ProductTypeDao productTypeDao;

    @Override
    public PageInfo<ProductType> queryAllProductType(String name,int page,int limit) {
        //传入参数，每页条数 当前页
        PageHelper.startPage(page,limit);
        List<ProductType> list = productTypeDao.queryAllProductType(name);
        //通过包装获取分页需要的其他值信息
        PageInfo<ProductType> pageInfo = new PageInfo<>(list);
        return pageInfo;


    }

    @Override
    public void addProdudctTypeSubmit(ProductType productType) {
        productTypeDao.addProdudctTypeSubmit(productType);
    }

    @Override
    public ProductType queryProductTypeById(Integer id) {
        return productTypeDao.queryProductTypeById(id);
    }

    @Override
    public void updateProductTypeSubmit(ProductType productType) {
       productTypeDao.updateProductTypeSubmit(productType);
    }

    @Override
    public void deleteProductTypeByIds(List<String> id) {
        List<Integer> list=new ArrayList<>();
        for(String cid:id){
            int id2= Integer.valueOf(cid);
            list.add(id2);
        }
        productTypeDao.deleteProductTypeByIds(list);
    }
}
