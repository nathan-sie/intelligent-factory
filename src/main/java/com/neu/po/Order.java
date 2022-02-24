package com.neu.po;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private int id;
    private String ono;
    private int pid;
    private int num;
    private String ddl;
    private String deliver;
    private String receiver;
    private int status;
    private int mobile;
    private String address;

    private User user;

}
