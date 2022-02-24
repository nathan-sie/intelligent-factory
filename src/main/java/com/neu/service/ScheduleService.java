package com.neu.service;

import com.github.pagehelper.PageInfo;
import com.neu.po.Schedule;
import org.springframework.stereotype.Component;

import java.util.List;


public interface ScheduleService {

    PageInfo<Schedule> queryAllSchedule(Integer oid,int page, int limit);

    void addScheduleSubmit(Schedule schedule);

    Schedule queryScheduleById(Integer id);

    void updateScheduleSubmit(Schedule schedule);

    void deleteScheduleByIds(List<String> id);

    void produceOrder(List<Integer> id);
}
