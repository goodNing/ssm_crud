package com.guigu.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.guigu.assist.Msg;
import com.guigu.entity.Employee;
import com.guigu.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;


import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmpController {
    @Autowired
    EmpService empService;

    //返回分页的json数据交由ajax异步处理
    @RequestMapping("/emps")
    @ResponseBody
    public Msg returnPage(@RequestParam(value = "page",defaultValue = "1")Integer page){
        //引入分页插件，给出当前页数及每页大小
        //查询前调用，使得其之后的一个方法是分页查询
        PageHelper.startPage(page,5);
        List<Employee> emps = empService.getAll();

        //PageInfo封装了分页有关的详细信息
        PageInfo pageInfo = new PageInfo(emps,5);

        return Msg.success().add("pageInfo",pageInfo);
    }

    //获取并保存传入的员工数据(加入后端JSR303校验用户名和邮箱)
    //添加一个员工信息（增）
    @RequestMapping(value = "/emps",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error:errors){
                System.out.println("错误字段名："+error.getField());
                System.out.println("错误信息："+error.getDefaultMessage());
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            empService.saveEmp(employee);
            return Msg.success();
        }

    }

   //根据id查询单个员工信息（查）
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("empId") Integer empId){
        Employee emp = empService.getEmpById(empId);
        return Msg.success().add("emp",emp);
    }
    //根据id修改单个员工信息（改）
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg getEmp(Employee employee){
        empService.updateEmp(employee);
        return Msg.success();
    }
    //根据id删除单个员工信息（删）
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg DelEmp(@PathVariable("empId") Integer empId){
        empService.DelEmpById(empId);
        return Msg.success();
    }

    //根据id列表批量删除员工信息
    @RequestMapping(value = "/emps",method = RequestMethod.DELETE,consumes="application/json;charset=utf-8")
    @ResponseBody
     public Msg DelBuntch(@RequestBody List<Integer> empIds){
        empService.BuntchDelEmpByIds(empIds);
        return Msg.success();
     }

    //校验用户名是否已重复
    @RequestMapping("/valid_name")
    @ResponseBody
    public Msg validName(String name){
        int count=empService.validName(name);
        System.out.print(count);
        if (count==0){
            return Msg.success();
        }else{
            return Msg.fail();
        }
    }


//    直接返回路径
//    @RequestMapping("/emps")
//    public String getAll(@RequestParam(value = "page",defaultValue = "1")Integer page, Model model){
//
//        //引入分页插件，给出当前页数及每页大小
//        //查询前调用，使得其之后的一个方法是分页查询
//        PageHelper.startPage(page,5);
//        List<Employee> emps = empService.getAll();
//
//        //PageInfo封装了分页有关的详细信息
//        PageInfo pageInfo = new PageInfo(emps,5);
//        model.addAttribute("pageInfo",pageInfo);
//        return "list";
//    }
}
