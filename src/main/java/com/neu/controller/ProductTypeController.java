package com.neu.controller;


import com.github.pagehelper.PageInfo;
import com.neu.po.ProductType;
import com.neu.service.ProductTypeService;
import com.neu.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.List;

@Controller
public class ProductTypeController {
    @Autowired
    private ProductTypeService productTypeService;

    @GetMapping("/productTypeIndex")
    public String productTypeIndex(){
        return "/productType/productTypeIndex";
    };

    @RequestMapping("/productTypeAll")
    @ResponseBody
    public R productTypeAll(String name, @RequestParam(defaultValue = "1")Integer page, @RequestParam(defaultValue = "5")Integer limit){

        PageInfo<ProductType> pageInfo = productTypeService.queryAllProductType(name,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }

    @GetMapping("/productTypeAdd")
    public String productTypeAdd(){
        return "/productType/productTypeAdd";
    }

    @ResponseBody
    @RequestMapping("/productTypeAddSubmit")
    public R addProdudctTypeSubmit(ProductType productType){
        productTypeService.addProdudctTypeSubmit(productType);
        return R.ok();

    }

    @GetMapping("/queryProductTypeById")
    public String queryProductTypeById(Integer id, Model model){
       ProductType productType = productTypeService.queryProductTypeById(id);
        model.addAttribute("productType",productType);
        return "/productType/productTypeUpdate";
    }

    @ResponseBody
    @RequestMapping("/productTypeUpdateSubmit")
    public R updateProdudctTypeSubmit(@RequestBody ProductType productType){
        productTypeService.updateProductTypeSubmit(productType);
        return R.ok();

    }

    @ResponseBody
    @RequestMapping("/productTypeDelete")
    public R productTypeDelete(String ids){
        List list = Arrays.asList(ids.split(","));
        productTypeService.deleteProductTypeByIds(list);
        return R.ok();
    }

    @ResponseBody
    @RequestMapping("/findAllProductList")
    public List<ProductType> findAll(){
        PageInfo<ProductType> pageInfo=productTypeService.queryAllProductType(null,1,100);
        List<ProductType> lists=pageInfo.getList();
        return lists;
    }



}
