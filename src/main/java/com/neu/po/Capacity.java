package com.neu.po;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Capacity {
    private int id;
    private int did;
    private int pid;
    private int capacity;

    private Device device;
}
