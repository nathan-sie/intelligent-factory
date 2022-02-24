package com.neu.po;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Schedule {
    private int id;
    private int did;
    private int oid;
    private String f_name;
    private String begin;
    private String end;

}
