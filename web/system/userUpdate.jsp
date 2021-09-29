
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>无标题文档</title>
    <script type="text/javascript" src="/egov/js/Egov.js"></script>
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

    <script>
        function doUpdate() {
           var flag = validateForm();
            if (flag == true){
                var updateObj = document.getElementById("doUpdate");
                updateObj.submit();
            }
        }
        function validateForm() {
            //创建FormItem对象
            var formItem1 =new FormItem("用户姓名","username");
            var formItem2 =new FormItem("用户密码","userpswd");
            var formItem3 =new FormItem("确认密码","checkpswd");
            var formItem4 =new FormItem("机构类型","orgtype");

            //创建数组对象
            var formItemArr = [formItem1,formItem2,formItem3,formItem4];
            return EGOV.isNotEmpty(formItemArr) && EGOV.isSame(formItem2,formItem3);

        }
    </script>
</head>

<body>
<form action="/egov/servlet/doUpdate" method="post" id="doUpdate">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="15" height="30"><img src="/egov/images/tab_03.gif" width="15" height="30" /></td>
                <td width="1101" background="/egov/images/tab_05.gif"><img src="/egov/images/311.gif" width="16" height="16" /> <span class="STYLE4">修改系统用户</span></td>
                <td width="281" background="/egov/images/tab_05.gif"><table border="0" align="right" cellpadding="0" cellspacing="0">
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
                    <tr height="26"></tr>
                    <tr>
                        <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">用户代码</div></td>
                        <td bgcolor="#FFFFFF" class="STYLE1">
                            <div align="left" style="padding:2px" class="STYLE2">${user.usercode}</div>
                            <input id="usercode" name="usercode" value="${user.usercode}"type="hidden"/><%--hidden隐藏域 提交用户代码--%>
                            <input name="pageno" type="hidden" value="<%=request.getParameter("pageno")%>"/><%--提交user.jsp当前页数--%>
                        </td>
                    </tr>
                    <tr>
                        <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">用户姓名</div></td>
                        <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" id="username" name="username" value="${requestScope.user.uesrname}" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
                    </tr>
                    <tr>
                        <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">用户密码</div></td>
                        <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="password" id="userpswd" name="userpswd" value="${requestScope.user.userpswd} style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
                    </tr>
                    <tr>
                        <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">确认密码</div></td>
                        <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="password" id="checkpswd" name="checkpswd" value="${requestScope.user.userpswd} style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
                    </tr>
                    <tr>
                        <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px"  class="STYLE2 STYLE1">机构类型</div></td>
                        <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2">
                            <select name="orgtype"id="orgtype" style="width:105px; height:20px; border:solid 1px #035551; color:#000000">
                                <option value=""></option>
                                <option value="0" ${"0".equals(requestScope.user.orgtype) ?"selected":""}>外汇管理局</option>
                                <option value="1" ${"1".equals(requestScope.user.orgtype) ?"selected":""}>银行</option>
                            </select>&nbsp;<font color='red'>*</font></div></td>
                    </tr>
                </table></td>
                <td width="9" background="/egov/images/tab_16.gif">&nbsp;</td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="9" background="/egov/images/tab_12.gif">&nbsp;</td>
                <td bgcolor="#f3ffe3"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68">
                    <tr height="26">
                        <td bgcolor="#FFFFFF" height="26" class="STYLE1" colspan="2" style="padding-top:5px;padding-left:200px">
                            <img src="/egov/images/save.jpg"  style="cursor:hand" onclick="doUpdate()" />&nbsp;&nbsp;
                            <img src="/egov/images/clear.jpg" style="cursor:hand" />
                        </td>
                    </tr>
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
                        <td width="75%" valign="top" class="STYLE1"><div align="left">
                            <table width="352" height="20" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="62" height="22" valign="middle"></td>
                                    <td width="50" height="22" valign="middle"></td>
                                </tr>
                            </table>
                        </div></td>
                    </tr>
                </table></td>
                <td width="14"><img src="/egov/images/tab_22.gif" width="14" height="29" /></td>
            </tr>
        </table></td>
    </tr>
</table>
</form>
</body>
</html>
