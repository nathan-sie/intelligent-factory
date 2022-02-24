package com.neu.dao;

import com.neu.po.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("UserMapper")
public interface UserMapper {

    List<User> queryAllUser(@Param(value = "name") String name);

    //增加
    void addUserSubmit(User user);

    void addFactorySubmit(User user);

    //修改
    User queryUserById(Integer id);

    void updateUserSubmit(User user);

    void deleteUserByIds(List<Integer> id);



    User queryUserByNameAndPassword(@Param("username") String username,@Param("password")  String password);
}