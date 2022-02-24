package com.neu.po;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Rent {
    private int id;
    private int did;
    private String f_name;
    private String begin;
    private String end;
}
