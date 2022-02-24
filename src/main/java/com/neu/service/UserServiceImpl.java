package com.neu.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neu.dao.UserMapper;
import com.neu.po.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService{

    @Autowired
    private UserMapper userMapper;
    @Override
    public PageInfo<User> queryAllUser(String name, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<User> list = userMapper.queryAllUser(name);
        PageInfo<User> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public void addUserSubmit(User user) {
        userMapper.addUserSubmit(user);

    }

    @Override
    public void addFactorySubmit(User user) {
        userMapper.addFactorySubmit(user);
    }

    @Override
    public User queryUserById(Integer id) {
       return userMapper.queryUserById(id);
    }

    @Override
    public void updateUserSubmit(User user) {
       userMapper.updateUserSubmit(user);
    }

    @Override
    public void deleteUserByIds(List<String> id) {
        List<Integer> list=new ArrayList<>();
        for(String cid:id){
            int id2= Integer.valueOf(cid);
            list.add(id2);
        }
        userMapper.deleteUserByIds(list);

    }

    @Override
    public User queryUserByNameAndPassword(String username, String password) {
        return userMapper.queryUserByNameAndPassword(username,password);
    }
}
