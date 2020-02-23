<%--
  Created by IntelliJ IDEA.
  User: 11196
  Date: 2020/2/18
  Time: 17:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("APP_PATH",request.getContextPath()); %>
<html>
<head>
    <title>员工列表</title>
</head>
<%--web路径:无/开始：当前资源路径   有/开始，服务器路径，例如http://localhost:8080
需要加上项目名称--%>
<script type="text/javascript" src="${APP_PATH}/static/jquery/jquery-3.4.1/jquery-3.4.1.min.js"></script>
<script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css">
<body>
<!-- 添加员工的模态框 -->
<div class="modal fade" id="add_emp_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_emp_name" name="empName" placeholder="empName" required="required">
                            <span></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="add_emp_email" name="email" placeholder="xx@xx.com" required="required">
                            <span></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="add_emp_gender1" value="1" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="add_emp_gender2" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="add_emp_dept" name="dId">
                                <option value="1">开发部</option>
                                <option value="2">测试部</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_emp_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改员工的模态框 -->
<div class="modal fade" id="update_emp_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">修改员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="update_emp_static_name"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="update_emp_email" name="email" placeholder="xx@xx.com" required="required">
                            <span></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="1" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="update_emp_dept" name="dId">
                                <option value="1">开发部</option>
                                <option value="2">测试部</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                <button type="button" class="btn btn-primary" id="update_emp_btn">修改</button>
            </div>
        </div>
    </div>
</div>

<%--搭建bootstrap栅格系统的显示界面--%>
<div class="container">
    <div class="row"><%--标题--%>
        <div class="col-md-8 col-md-offset-4"><h1>SSM-CRUD</h1></div>
    </div>

    <div class="row"><%--按钮--%>
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="add_emp_btn">新增</button>
            <button class="btn btn-danger"  id="del_emp_btn">删除</button>
        </div>
    </div>

    <div class="row"><%--表格--%>
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all"/></th>
                        <th>#</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <%-- 显示分页信息--%>
    <div class="row">
        <div class="col-md-6" id="page_count">

        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination" id="page_nav">

                </ul>
            </nav>
        </div>
    </div>
</div>
    <script type="text/javascript">
        var totalPage, currentPage;
        //页面加载完成后，直接去发送ajax请求，获取数据
        $(function () {
            //初始请求page=1的查询页面
            to_page(1);
        });

        //ajax查询请求
        function to_page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"page="+pn,
                type:"get",
                success:function (result) {//注意：一定要记得传值啊
                    totalPage=result.m.pageInfo.total;
                    currentPage=result.m.pageInfo.pageNum;
                    buildEmpTable(result);
                    buildPageNav(result);
                }
            });

        }

        //构建查询的员工列表信息
        function buildEmpTable(result) {
            $("#emps_table tbody").empty();
            var emps=result.m.pageInfo.list;
            $.each(emps,function (index,item) {
                var checkBoxTd=$("<td></td>").append($("<input type='checkbox' class='check_item'/>"));
                var empIdTd=$("<td></td>").append(item.empId);
                var empNameTd=$("<td></td>").append(item.empName);
                var genderTd=$("<td></td>").append(item.gender==0?'女':'男');
                var emailTd=$("<td></td>").append(item.email);
                var deptNameTd=$("<td></td>").append(item.department.deptName);
                var updBtn=$("<button></button>").addClass("btn btn-primary btn-sm btn-update")
                    .append("<scan></scan>").addClass("glyphicon glyphicon-pencil")
                    .append("编辑");
                $(updBtn).attr("emp_id",item.empId);
                var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm btn-delete")
                    .append("<scan></scan>").addClass("glyphicon glyphicon-trash")
                    .append("删除");
                $(delBtn).attr("emp_id",item.empId);
                var btnTd=$("<td></td>").append(updBtn).append(" ").append(delBtn);
                $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(genderTd)
                    .append(emailTd).append(deptNameTd).append(btnTd)
                    .appendTo("#emps_table tbody");
            });
        }

        //构建出查询得到的具体分页信息
        function buildPageNav(result) {
            $("#page_count").empty();
            $("#page_nav").empty();
            var pageinfo=result.m.pageInfo;
            var navnums=pageinfo.navigatepageNums;
            $("#page_count").append(pageinfo.pageNum+"/"+pageinfo.pages+"，共"+pageinfo.total+"条记录");

            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
            var previousPageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if(pageinfo.isFirstPage){
                $(firstPageLi).addClass("disabled");
                $(previousPageLi).addClass("disabled");
            }else{
                firstPageLi.click(function () {
                    to_page(1);
                });
                previousPageLi.click(function () {
                    to_page(pageinfo.prePage);
                })
            }

            $("#page_nav").append(firstPageLi).append(previousPageLi);

            $.each(navnums,function (index,item) {
                var indexLi=$("<li></li>").append($("<a></a>").append(item));
                if(item==pageinfo.pageNum){
                    indexLi.addClass("active");
                }
                indexLi.click(function () {
                    to_page(item);
                });
                $("#page_nav").append(indexLi);
            });

            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页"));
            if(pageinfo.isLastPage){
                $(nextPageLi).addClass("disabled");
                $(lastPageLi).addClass("disabled");
            }else{
                nextPageLi.click(function () {
                    to_page(pageinfo.nextPage);
                });
                lastPageLi.click(function () {
                    to_page(pageinfo.pages);
                })
            }
            $("#page_nav").append(nextPageLi).append(lastPageLi);
        }

        //添加员工的模态框
        $("#add_emp_btn").click(function () {
            $("#add_emp_modal").modal({
                backdrop:"static"
            });
        });

        //jquery验证邮箱格式
        $("#add_emp_email").change(function () {
            var email=$(this).val();
            if(email==null||email==""){
                show_valid_msg("#add_emp_email","fail","邮箱不能为空");
            }else {
                var myreg = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
                if(!myreg.test(email)){
                    show_valid_msg("#add_emp_email", "fail", "邮箱格式错误");
                }else{
                show_valid_msg("#add_emp_email", "success", "");
                }
            }
        });

        $("#update_emp_email").change(function () {
            var email=$(this).val();
            if(email==null||email==""){
                show_valid_msg("#update_emp_email","fail","邮箱不能为空");
            }else {
                var myreg = /^([\.a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;
                if(!myreg.test(email)){
                    show_valid_msg("#update_emp_email", "fail", "邮箱格式错误");
                }else{
                    show_valid_msg("#update_emp_email", "success", "");
                }
            }
        });

        //校验用户名的绑定函数
        $("#add_emp_name").change(function () {
            //前端判空
            if($(this).val()==null||$(this).val()==""){
                show_valid_msg("#add_emp_name","fail","用户名不能为空");
                return false;
            }
            //后端判重
            $.ajax({
                url:"${APP_PATH}/valid_name",
                method: "GET",
                data:"name="+$("#add_emp_name").val(),
                success:function (result) {
                    if(result.flag==1){
                        show_valid_msg("#add_emp_name","success","用户名可用！")
                    }else{
                        show_valid_msg("#add_emp_name","fail","用户名已被占用")
                    }
                }
            })
        });


        //显示校验信息函数
        function show_valid_msg(ele,status,msg){
            $(ele).parent().removeClass("has-success has-error");
            if(status=="success"){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
                $(ele).attr("valid","pass");
            }else{
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
                $(ele).attr("valid","error");
            }
        }

        //发送保存员工的ajax请求
        //数据校验出问题，返回错误信息，并阻止表单提交
        //成功保存数据后，提示状态信息，关闭模态框，自动跳转到末页显示
        $("#save_emp_btn").click(function () {
            //根据判别信息控制跳转
            if($("#add_emp_name").attr("valid")=="error"||$("#add_emp_email").attr("valid")=="error"){
                return false;
            }

            $.ajax({
                url: "${APP_PATH}/emps",
                method:"POST",
                data:$("#add_emp_modal form").serialize(),
                success:function (result) {
                    if(result.flag==1){
                        //成功提交
                        alert("添加成功！");
                        $("#add_emp_modal").modal("hide");
                        to_page(totalPage+1);}
                        else{
                        //校验错误
                        show_valid_msg("#add_emp_email","fail","邮箱格式错误");
                    }
                }
            })
        });

        //员工编辑按钮的绑定函数
        //使用on方法可以对尚未生成的标签也进行赋值
        $(document).on("click",".btn-update",function () {
            //点击编辑按钮，跳出模态框，显示员工信息
            var empId=$(this).attr("emp_id");
            $("#update_emp_btn").attr("emp_id",empId);
            getEmp(empId);
            $("#update_emp_modal").modal({
                backdrop:"static"
            });

        });

        //点击修改，修改员工信息
        $("#update_emp_btn").click(function () {
            //前端校验
            if($("#update_emp_email").attr("valid")=="error") return false;

            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("emp_id"),
                method:"PUT",
                data:$("#update_emp_modal form").serialize(),
                success:function (result) {
                    alert("修改成功！");
                    $("#update_emp_modal").modal("hide");
                    to_page(currentPage);
                }
            })
        });

        //根据id获取该员工信息
        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                method: "GET",
                success:function (result) {
                    var emp = result.m.emp;
                    $("#update_emp_static_name").text(emp.empName);
                    $("#update_emp_email").val(emp.email);
                    $("#update_emp_modal input[name=gender]").val([emp.gender]);
                    $("#update_emp_modal select").val([emp.dId]);
                }
            })
        }

        //点击员工的删除按钮，出现确认框
        $(document).on("click",".btn-delete",function () {
            var name = $(this).parents("tr").find("td:eq(2)").text();
            var flag = confirm("确认删除员工 "+name+" ?");
            if(!flag) return false;
            //删除单个员工信息
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("emp_id"),
                method:"DELETE",
                success:function () {
                    alert("删除成功！");
                    to_page(currentPage);
                }
            })
        });

        //全选/全不选
        $("#check_all").click(function () {
            //注意：prop读dom原生属性的值，attr读自定义属性的值
            $(".check_item").prop("checked",$("#check_all").prop("checked"));
        });

        $("#del_emp_btn").click(function () {
            var empIds = [];
            var empnames = [];
            $.each($(".check_item:checked"),function () {
                empnames.push($(this).parents("tr").find("td:eq(2)").text());
                empIds.push($(this).parents("tr").find("td:eq(1)").text());
            });

            var flag = confirm("确认批量删除以下员工？\n"+JSON.stringify(empnames));
            if(!flag) return false;

            $.ajax({
                url:"${APP_PATH}/emps",
                method:"DELETE",
                contentType:"application/json;charset=utf-8",
                data:JSON.stringify(empIds),
                success:function () {
                    alert("批量删除完成");
                    to_page(currentPage);
                }
            })
        })
    </script>
</body>
</html>
