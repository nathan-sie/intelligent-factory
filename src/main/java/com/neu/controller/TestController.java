package com.neu.controller;

import com.neu.po.ProductType;
import com.neu.service.ProductTypeService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class TestController {

    @Autowired
    private ProductTypeService productTypeService;

    /*@RequestMapping("/test")
    public String testIndex(){
        productTypeService.queryAllProductType();
        System.out.println("fuck");
        return  "/test";
    } */
}
