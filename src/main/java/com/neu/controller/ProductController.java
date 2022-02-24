package com.neu.controller;

import com.github.pagehelper.PageInfo;
import com.neu.po.Product;
import com.neu.service.ProductService;
import com.neu.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping("/productIndex")
    public String productIndex(){
        return "/product/productIndex";
    };

    @ResponseBody
    @RequestMapping("/productAll")
    public R productAll(String name, Integer tid, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "5") Integer limit){
        PageInfo<Product> pageInfo = productService.queryAllProduct(name,tid,page,limit);
        return R.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }
    @GetMapping("/productAdd")
    public String productAdd(){
        return "/product/productAdd";
    }

    @ResponseBody
    @RequestMapping("/productAddSubmit")
    public R addProdudctSubmit(Product product){
        productService.addProductSubmit(product);
        return R.ok();

    }

    @GetMapping("/queryProductById")
    public String queryProductById(Integer id, Model model){
        Product product = productService.queryProductById(id);
        model.addAttribute("product",product);
        return "/product/productUpdate";
    }

    @GetMapping("/queryProductById2")
    public String queryProductById2(Integer id, Model model){
        Product product = productService.queryProductById(id);
        model.addAttribute("product",product);
        return "/product/productUpdate2";
    }


    @ResponseBody
    @RequestMapping("/productUpdateSubmit")
    public R updateProdudctSubmit(@RequestBody Product product){
        productService.updateProductSubmit(product);
        return R.ok();

    }

    @ResponseBody
    @RequestMapping("/productUpdateSubmit2")
    public R updateProdudctSubmit2(@RequestBody Product product){
        productService.updateProductSubmit2(product);
        return R.ok();

    }

    @ResponseBody
    @RequestMapping("/productDelete")
    public R productDelete(String ids){
        List list = Arrays.asList(ids.split(","));
        productService.deleteProductByIds(list);
        return R.ok();
    }

}
