package com.neu.service;

import com.github.pagehelper.PageInfo;
import com.neu.po.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;

import java.util.List;


public interface UserService {


    public PageInfo<User> queryAllUser(String name, int page, int limit);

    //增加
    void addUserSubmit(User user);

    void addFactorySubmit(User user);

    //修改
    User queryUserById(Integer id);

    void updateUserSubmit(User user);

    void deleteUserByIds(List<String> id);

    User queryUserByNameAndPassword(String username, String password);

}