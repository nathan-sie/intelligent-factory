package com.neu.dao;

import com.neu.po.Capacity;
import com.neu.po.Schedule;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("ScheduleMapper")
public interface ScheduleMapper {

    List<Schedule>  queryAllSchedule(@Param(value = "oid") Integer oid );

    void addScheduleSubmit(Schedule schedule);

    Schedule queryScheduleById(Integer id);

    void updateScheduleSubmit(Schedule schedule);

    void deleteScheduleByIds(List<Integer> id);

    void produceOrder(List<Integer> id);
}
