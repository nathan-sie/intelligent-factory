package com.neu.po;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {
    private int id;
    private int tid;
    private String name;
    private String norms;
    private String intro;
    private String pno;
    private ProductType productType;
}
