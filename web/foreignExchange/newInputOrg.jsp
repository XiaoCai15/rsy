<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<head>
  <base href="<%=basePath%>">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <script type="text/javascript" src="clander/date.js"></script>
  <script type="text/javascript" src="clander/setday.js"></script>
  <script>document.onclick=function() {}</script>
  <title>无标题文档</title>
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
    window.onload =function (){
      <%
          Object error = request.getAttribute("errorMsg");
          if (error != null){
      %>
          alert("<%=error%>");
      <%
          }
      %>
    }
    function checkOrgcode(){
        var Obj = document.getElementById("orgcode");
        if(Obj.value == ""){
          alert("组织机构代码不能为空，请填写");
          Obj.focus();
          return;
      }else {
        document.forms["enForm"].submit();
/*        var xhr =new XMLHttpRequest();
        xhr.onreadystatechange =function (){
          if (xhr.readyState == 4 && xhr.status == 200){
            document.getElementById("ErrorCode").innerHTML = xhr.responseText;
          }
        }
        xhr.open("POST","/egov/servlet/checkOrgCode",true);
        xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
        xhr.send("orgcode="+Obj.value);*/
      }
    }
  </script>
</head>

<body>
<form action="servlet/checkOrgCode" method="post" name="enForm">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="images/tab_05.gif"><img src="images/311.gif" width="16" height="16" /> <span class="STYLE4">新设外商企业登记-录入</span></td>
        <td width="281" background="images/tab_05.gif"><table border="0" align="right" cellpadding="0" cellspacing="0">
          <tr>
            <td width="60"><table width="90%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td class="STYLE1"></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td width="14"><img src="images/tab_07.gif" width="14" height="30" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr height="5">
        <td width="9" background="images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3">&nbsp;</td>
        <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
      <tr>
        <td width="9" background="images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3">
          <table width="99%" border="0" align="center" cellpadding="0" cellspacing="1">
            <tr>
              <td width="90" class="STYLE1">组织机构代码:</td>
              <td width="140" class="STYLE1">
                <input type="text" name="orgcode" id="orgcode" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">
              </td>
              <td width="180" class="STYLE1">
                <button id="addBtn" style="padding-left:0px;padding-top:0px;width:68px;height:27px" onclick="checkOrgcode()" >
                  <img id="addBtnImg" src="images/ok.jpg" />
                </button>
              </td>
              <td class="STYLE1">&nbsp;</td>
              <td><div id="ErrorCode"></div></td>
            </tr>

          </table>
        </td>
        <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
    </table>
  </tr>
  <tr>
    <td height="29"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="29"><img src="images/tab_20.gif" width="15" height="29" /></td>
        <td background="images/tab_21.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="25%" height="29" nowrap="nowrap"><span class="STYLE1">&nbsp;</td>
            <td width="75%" valign="top" class="STYLE1"><div align="right">&nbsp;</div></td>
          </tr>
        </table></td>
        <td width="14"><img src="images/tab_22.gif" width="14" height="29" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>

</html>

