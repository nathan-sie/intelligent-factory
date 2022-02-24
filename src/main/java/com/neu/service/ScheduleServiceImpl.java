package com.neu.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neu.dao.ScheduleMapper;
import com.neu.po.Schedule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("ScheduleService")
public class ScheduleServiceImpl implements ScheduleService{

    @Autowired
    private ScheduleMapper scheduleMapper;

    @Override
    public PageInfo<Schedule> queryAllSchedule(Integer oid, int page, int limit) {
        PageHelper.startPage(page,limit);
        List<Schedule> list = scheduleMapper.queryAllSchedule(oid);
        PageInfo<Schedule> pageInfo = new PageInfo<>(list);
        return pageInfo;


    }

    @Override
    public void addScheduleSubmit(Schedule schedule) {
        scheduleMapper.addScheduleSubmit(schedule);
    }

    @Override
    public Schedule queryScheduleById(Integer id) {
        return scheduleMapper.queryScheduleById(id);
    }

    @Override
    public void updateScheduleSubmit(Schedule schedule) {
        scheduleMapper.updateScheduleSubmit(schedule);
    }

    @Override
    public void deleteScheduleByIds(List<String> id) {
        List<Integer> list = new ArrayList<>();
        for (String cid : id) {
            int id2 = Integer.valueOf(cid);
            list.add(id2);
        }
        scheduleMapper.deleteScheduleByIds(list);
    }

    @Override
    public void produceOrder(List<Integer> id) {
        scheduleMapper.produceOrder(id);
    }
}
