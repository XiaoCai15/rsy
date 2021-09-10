<%--
  Created by IntelliJ IDEA.
  User: 任书怡
  Date: 2021/7/20
  Time: 2:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.rsy.entity.Users" %>
<%@ page import="com.rsy.util.StringUtil" %>
<%@ page import="com.rsy.entity.Page" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>无标题文档</title>
    <script type="text/javascript" src="/egov/JS-jar/jquery-3.6.0.js"></script>
    <style type="text/css">
        <!--
        body {
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
        }
        .STYLE1 {font-size: 12px}
        .STYLE4 {
            font-size: 12px;
            color: #1F4A65;
            font-weight: bold;
        }

        a:link {
            font-size: 12px;
            color: #06482a;
            text-decoration: none;

        }
        a:visited {
            font-size: 12px;
            color: #06482a;
            text-decoration: none;
        }
        a:hover {
            font-size: 12px;
            color: #FF0000;
            text-decoration: underline;
        }
        a:active {
            font-size: 12px;
            color: #FF0000;
            text-decoration: none;
        }
        .STYLE7 {font-size: 12}

        -->
    </style>

    <script type="text/javascript">

        function changePage(pageno) {
            document.location="/egov/servlet/PageQuery?pageno="+pageno;
        }

        function pageNum(pagecount){
            var pageNum = document.getElementById("pageNum");
            var pageno = pageNum.value;
            pageno = pageno.trim();
            if (pageno == "" ){
                changePage(1);
                return;
            }
            if(isNaN(pageno)){
                alert("请重新输入数字");
                pageNum.value="";
                pageNum.focus();
                return;
            }
            var pageno = parseInt(pageno);//js将字符串转为number
            if (pageno > pagecount){
                changePage(pagecount);
                return;
            }
            if (pageno <=0){
                changePage(1);
                return;
            }

            changePage(pageno);



        }
        /*删除和添加图片联动*/
       function controDeleteAndUpdateImg() {
            var checkedCound = 0;
            var obj = $(":checkbox");

           /* var update = $("#update");
            var delete = $("#delete");*/
            for (var i=1;i < obj.length;i++){
                if(obj[i].checked){
                    checkedCound++;

                }
            }
            if (checkedCound == 0){
                $("#update").attr("src","/egov/images/update_disabled.jpg");
                $("#delete").attr("src","/egov/images/delete_disabled.jpg");
                $("#update").attr("disabled",true);
                $("#delete").attr("disabled",true);
            }
           if (checkedCound == 1){
               $("#update").attr("src", "/egov/images/update.jpg");
               $("#delete").attr("src", "/egov/images/delete.jpg");
               $("#update").attr("disabled",false);
               $("#delete").attr("disabled",false);
           }
           if (checkedCound > 1){
               $("#update").attr("src","/egov/images/delete_disabled.jpg");
               $("#delete").attr("src", "/egov/images/delete.jpg");
               $("#update").attr("disabled",true);
               $("#delete").attr("disabled",false);
           }
           var allobj = document.getElementById("checkAll");
           if (checkedCound == obj.length -1){
               allobj.checked = true;
           }else {
               allobj.checked = false;
           }
       }
        /*全选*/
        function checkboxAll() {
            var obj = $(":checkbox");


            if (obj[0].checked == true){
                for (var i=1;obj.length;i++){
                    obj[i].checked = true;
                    controDeleteAndUpdateImg();
                }
            }else {

                    for (var i=1;obj.length;i++){
                        obj[i].checked = false;
                        controDeleteAndUpdateImg();
                    }
            }

        }
        /*
        *   HTML页面执行顺序为自上而下；window.οnlοad=function() {}会等页面全部加载完毕后再执行。
        *   基于上面两点，当程序执行到window.onload的时候，不会去解析里面的内容。但是，当解析到div标签上的onclick函数的时候，就会去找add()函数，这个时候发现程序里面是没有的，所以就会报错。
        */
    function goUpdate() {
        $("#userForme").attr("action","/egov/servlet/goUpdate");
        $("#userForme").submit();
    }
    function doDelete(){
        if(window.confirm("确定删除信息吗？")){
            $("#userForme").attr("action","/egov/servlet/doDelete");
            $("#userForme").submit();
        }
    }

    </script>
</head>

<body onload="controDeleteAndUpdateImg()">
<form  method="post" name="userForme" id="userForme">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="15" height="30"><img src="/egov/images/tab_03.gif" width="15" height="30" /></td>
                <td width="1101" background="/egov/images/tab_05.gif"><img src="/egov/images/311.gif" width="16" height="16" /> <span class="STYLE4">系统用户列表</span></td>
                <td width="281" background="/egov/images/tab_05.gif"><table border="0" align="right" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="STYLE1"><div align="center"><img src="/egov/images/add.jpg" style="cursor:hand" onclick="document.location='/egov/system/userAdd.jsp'"/></div></td>
                            </tr>
                        </table></td>
                        <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="STYLE1">
                                    <div align="center">
                                    <input type="image" id="update" src="/egov/images/update_disabled.jpg" style="cursor:hand"  onclick="goUpdate()"/>
                                    </div>
                                </td>
                            </tr>
                        </table></td>
                        <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="STYLE1"><div align="center"><input type="image" id="delete" src="/egov/images/delete_disabled.jpg" style="cursor:hand" onclick="doDelete()"/></div></td>
                            </tr>
                        </table></td>
                    </tr>
                </table></td>
                <td width="14"><img src="/egov/images/tab_07.gif" width="14" height="30" /></td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="9" background="/egov/images/tab_12.gif">&nbsp;</td>
                <td bgcolor="#f3ffe3"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68" >
                    <tr>
                        <td width="6%" height="26" background="/egov/images/tab_14.gif" class="STYLE1">
                            <div align="center" class="STYLE2 STYLE1">
                                <input type="checkbox" id="checkAll" onclick="checkboxAll()" name="checkbox62" value="checkbox" />
                            </div>
                        </td>
                        <td width="8%" height="18" background="/egov/images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">序号</div></td>
                        <td width="12%" height="18" background="/egov/images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">用户代码</div></td>
                        <td width="24%" height="18" background="/egov/images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2">用户姓名</div></td>
                        <td width="38%" height="18" background="/egov/images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">机构类型</div></td>
                    </tr>
                    <%
                        Page<Users> pageObj= (Page<Users>) request.getAttribute("pageObj");
                        //用户列表信息
                        List<Users> usersList =pageObj.getDataList();
                        //总页数
                       int pageCount = pageObj.getPageCount();
                        //总记录数
                        int totalsize = pageObj.getTotalsize();
                        //每页显示的记录条数
                        int pagesize  = pageObj.getPagesize();
                        //第几页
                        int pageno    = pageObj.getPageno();

                    %>
                    <%
                        int i =0;
                        for (Users user:usersList) {
                    %>


                    <tr>
                        <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE1">
                            <input name="usercode" type="checkbox" onclick="controDeleteAndUpdateImg()" class="STYLE2" value="<%=user.getUsercode()%>" />
                        </div></td>
                        <td height="18" bgcolor="#FFFFFF" class="STYLE2"><div align="center" class="STYLE2 STYLE1"><%=++i%></div></td>
                        <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"><%=user.getUsercode()%></div></td>
                        <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"><%=user.getUesrname()%></div></td>
                        <td height="18" bgcolor="#FFFFFF"><div align="center" ><a href="#"><%=StringUtil.getTextBycode(user.getOrgtype())%></a></div></td>
                    </tr>
                    <%
                        }
                    %>


                </table></td>
                <td width="9" background="/egov/images/tab_16.gif">&nbsp;</td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td height="29"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="15" height="29"><img src="/egov/images/tab_20.gif" width="15" height="29" /></td>
                <td background="/egov/images/tab_21.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="25%" height="29" nowrap="nowrap">
                            <%-- <span class="STYLE1">共<%=totalsize%>条纪录，当前第<%=pageno%>/<%=pageCount%>页，每页<%=pagesize%>条纪录</span>--%>
                              <%--使用el表达式--%>
                             <span class="STYLE1">共${requestScope.pageObj.totalsize}条纪录，当前第${requestScope.pageObj.pageno}/${requestScope.pageObj.pageCount}页，每页最多${requestScope.pageObj.pagesize}条纪录</span>
                            <%--隐藏域提交当前页码--%>
                                <input type="hidden" value="<%=pageno%>" name="pageno"/>
                        </td>

                        <td width="75%" valign="top" class="STYLE1"><div align="right">
                            <table width="352" height="20" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                   <%
                                        boolean isStartPage = pageno > 1;
                                        boolean isEndPage =pageno < pageCount;
                                    %>
                                    <%--<td width="30" height="22" valign="middle"><div align="right"><img src="/egov/images/firstPage<%=isStartPage? "":"Disabled"%>.gif" <%=isStartPage? "style='cursor:pointer'":""%> /></div></td>--%>
                                    <td width="30" height="22" valign="middle"><div align="right"><img src="/egov/images/firstPage<%=isStartPage? "":"Disabled"%>.gif" <%=isStartPage? "style='cursor:pointer'onclick='changePage(1)'":""%>  /></div></td>
                                    <td width="30" height="22" valign="middle"><div align="right"><img src="/egov/images/prevPage<%=isStartPage? "":"Disabled"%>.gif" <%=isStartPage? "style='cursor:pointer' onclick='changePage("+(pageno - 1)+")'":""%>/></div></td>
                                    <td width="30" height="22" valign="middle"><div align="right"><img src="/egov/images/nextPage<%=isEndPage? "":"Disabled"%>.gif"<%=isEndPage? "style='cursor:pointer' onclick='changePage("+(pageno + 1)+")'":""%> /></div></td>
                                    <td width="30" height="22" valign="middle"><div align="right"><img src="/egov/images/lastPage<%=isEndPage? "":"Disabled"%>.gif"<%=isEndPage? "style='cursor:pointer' onclick='changePage("+pageCount+")'":""%> /></div></td>

                                    <td width="59" height="22" valign="middle"><div align="right">转到第</div></td>
                                    <td width="25" height="22" valign="middle">
                                        <span class="STYLE7">
                                            <input id="pageNum" name="textfield" type="text" class="STYLE1" style="height:14px; width:25px;text-align:right" size="5" />
                                        </span>
                                    </td>
                                    <td width="23" height="22" valign="middle">页</td>
                                    <td width="30" height="22" valign="middle"><img src="/egov/images/go.gif" width="37" height="15" onclick='pageNum("+pageCount+")' style='cursor:pointer'/></td>
                                </tr>
                            </table>
                        </div></td>
                    </tr>
                </table></td>
                <td width="14"><img src="/egov/images/tab_22.gif" width="14" height="29" /></td>
            </tr>
        </table></td>
    </tr>
</form>
</table>
</body>
</html>

