package com.guigu.service;

import com.guigu.dao.EmployeeMapper;
import com.guigu.entity.Employee;
import com.guigu.entity.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmpService {
    @Autowired
    EmployeeMapper employeeMapper;

    public int validName(String name) {
        return employeeMapper.queryByName(name);
    }

    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    public int saveEmp(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }

    public Employee getEmpById(Integer empId) {
        return employeeMapper.selectByPrimaryKeyWithDept(empId);
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void DelEmpById(Integer empId) {
        employeeMapper.deleteByPrimaryKey(empId);
    }

    public void BuntchDelEmpByIds(List<Integer> empIds) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //delete from xxx where emp_id in(1,2,3...)
        criteria.andEmpIdIn(empIds);
        employeeMapper.deleteByExample(example);
    }
}
