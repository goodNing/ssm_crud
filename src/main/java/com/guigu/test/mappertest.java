package com.guigu.test;


import com.guigu.dao.DepartmentMapper;
import com.guigu.dao.EmployeeMapper;
import com.guigu.entity.Department;
import com.guigu.entity.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

//Spring测试,需要搭配4.2及以上的junit
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:contextApplication.xml"})
public class mappertest {
    @Autowired
    SqlSession sqlSession;
    @Autowired
    EmployeeMapper employeeMapper;
    @Test
    public void testCRUD(){
        //批量插入员工
//        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
//        for(int i = 0; i<1000; i++){
//            String uid = UUID.randomUUID().toString().substring(0,5)+i;
//            mapper.insertSelective(new Employee(null,uid,"1",uid+"@guigu.com",1));
//        }
        System.out.println(employeeMapper.selectByExampleWithDept(null));
    }
}
