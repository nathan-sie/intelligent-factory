package com.neu.po;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Factory {
    private int id;
    private int mobile;
    private String uname;
    private String name;
    private String intro;
    private int status;

    private User user;

}
