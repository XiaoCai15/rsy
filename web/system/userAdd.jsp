<%--
  Created by IntelliJ IDEA.
  User: 任书怡
  Date: 2021/7/25
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    <script >
     window.onload=function () {

         //提交表单
            /*doSave = function () {
                var flag = validateForm();

                if (flag) {
                    /!*document.forms：表示获取当前页面的所有表单
                      document.forms[0]：表示获取当前页面的第一个表单
                      document.forms['exportServlet']：表示获取当前页面的name="exportServlet"的表单
                       submit()表示提交函数
                    *!/
                    //document.forms[0].submit();
                    var saveFormeEit = document.getElementById("saveAdd");
                    saveFormeEit.submit();
                }

            }
            function  validateForm() {

                return true;
            }*/


        }
     /*AJAX POST请求校验用户代码是否已经存在*/

     function checkUsercode (usercode) {
         /*new XMLHttpRequest对象 */
         var xhr = new XMLHttpRequest();
         /*绑定事件*/
         xhr.onreadystatechange = function () {
             if (xhr.readyState == 4 && xhr.status == 200){
                 document.getElementById("ErrorUsercode").innerHTML = xhr.responseText;
             }
         }

         /*注册*/
         /** GET时间戳
          * open("GET","/egov/saveAdd?_="+new Date().getTime()+"&usercode="+usercode,true);
          **/
         /**
          * POST
          * AJAX在做请求前必须设置响应头内容类型 form中含有enctype属性xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");解决中文乱码
          */

         xhr.open("POST","/egov/servlet/checkUsercode",true);
         xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
         /*发送*/
         xhr.send("usercode="+usercode);
     }
     function doSave() {
         var errorObj = document.getElementById("ErrorUsercode");
         var usercodeObj = document.getElementById("usercode");
         var saveAddObj = document.getElementById("saveAdd");
         if (errorObj.innerHTML == ""){
             saveAddObj.submit();

         }else {
             alert("请重新填写用户代码");
             usercodeObj.value = "";
             usercodeObj.focus();
         }

     }

    </script>
</head>

<body>
<form action="/egov/servlet/saveAdd" method="post" id="saveAdd" >
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="15" height="30"><img src="/egov/images/tab_03.gif" width="15" height="30" /></td>
                    <td width="1101" background="/egov/images/tab_05.gif"><img src="/egov/images/311.gif" width="16" height="16" /> <span class="STYLE4">新增系统用户</span></td>
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
                            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1">
                                <div align="right" style="padding:5px" class="STYLE2 STYLE1">用户代码</div>
                            </td>
                            <td bgcolor="#FFFFFF" class="STYLE1">
                                <div align="left" style="padding:2px" class="STYLE2">
                                    <input type="text" name="usercode" id="usercode" onblur="checkUsercode(this.value)" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;
                                    <font color='red'>*</font>
                                    <span id="ErrorUsercode"></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">用户姓名</div></td>
                            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="username" id="username" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
                        </tr>
                        <tr>
                            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">用户密码</div></td>
                            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="password" name="userpswd" id="userpswd" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
                        </tr>
                        <tr>
                            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">确认密码</div></td>
                            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="password" name="checkpswd" id="checkpswd" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">&nbsp;<font color='red'>*</font></div></td>
                        </tr>
                        <tr>
                            <td width="200" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">机构类型</div></td>
                            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2">
                                <select id="orgtype" name="orgtype" style="width:105px; height:20px; border:solid 1px #035551; color:#000000">
                                    <option value=""></option>
                                    <option value="0">外汇管理局</option>
                                    <option value="1">银行</option>
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
                        <tr height="26"><td bgcolor="#FFFFFF" height="26" class="STYLE1" colspan="2" style="padding-top:5px;padding-left:200px"><img src="/egov/images/save.jpg" style="cursor:hand" onclick="doSave()" />&nbsp;&nbsp;<img src="/egov/images/clear.jpg" style="cursor:hand" /></td></tr>
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
