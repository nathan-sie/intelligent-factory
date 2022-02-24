package com.neu.po;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Bid {
    private int id;
    private String f_name;
    private String uname;
    private int oid;
    private String price;
    private String status;

    private User user;
    private Order order;

}
