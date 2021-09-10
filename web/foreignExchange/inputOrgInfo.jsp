<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<head>
  <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
  /*删除*/
  function delRow(id){
    var invListTable = document.getElementById("invListTable");
    var tableRow = document.getElementById(id);
    /*rowIndex用于判断当前单元格所处行的索引（从0开始）*/
    invListTable.deleteRow(tableRow.rowIndex);
    computeCap();
  }
  /*父子窗口数据传递*/
  function addNewLine(Invregnum,Invname,City){
    //获取表格
    var invListTable = document.getElementById("invListTable");

    //获取表格现有的总行数
    var index = invListTable.rows.length;
    //在表格末尾添加一行
    var tableRow = invListTable.insertRow(index);
    tableRow.style.background="white";
    tableRow.id = Invregnum;
    //给新行添加5个单元格
    var tableCell0 = tableRow.insertCell(0);
    var tableCell1 = tableRow.insertCell(1);
    var tableCell2 = tableRow.insertCell(2);
    var tableCell3 = tableRow.insertCell(3);
    var tableCell4 = tableRow.insertCell(4);
    //给每一个单元格设置HTML
    tableCell0.innerHTML = '<div align="center" style="padding:5px" class="STYLE2 STYLE1">'+Invname+'<input type="hidden" name="invregnum" value="'+Invregnum+'"/></div>';
    tableCell1.innerHTML = '<div align="center" style="padding:2px" class="STYLE2"><span name="city">'+City+'</span></div>';
    tableCell2.innerHTML = '<div align="center" style="padding:5px" class="STYLE2 STYLE1"><input type="text" name="regcapItem" onblur="computeCap()" style="width:90px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div>';
    tableCell3.innerHTML = '<div align="center" style="padding:2px" class="STYLE2"><input type="text" name="scale" style="width:90px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div>';
    tableCell4.innerHTML = '<div align="center" style="padding:2px" class="STYLE2"><img  onclick="delRow('+Invregnum+')" src="images/delete.jpg"/></div>';
    /* window.location.reload();*/
  }
  /*计算注册资金和外放注册资本*/
  function computeCap(){
    //获取所有的“注册资本出资额”输入框
    var regcapItems = document.getElementsByName("regcapItem");
    //获取所有的国别
    var citys = document.getElementsByName("city");
    //遍历数组
    var totalRegcap = 0;
    var outTotalRegcap = 0;
    for (var i=0;i<regcapItems.length;i++){
      var regcapItem = regcapItems[i];
      if (regcapItem.value != ""){
        totalRegcap += parseInt(regcapItem.value);
        //外方注册资本
        if (citys[i].innerText !="中国"){
          outTotalRegcap += parseInt(regcapItem.value);
        }
      }
    }
    //将注册资本设置到“注册资本”文本框
    var regcap = document.getElementById("regcap");
    regcap.value = totalRegcap;
    //外方注册资本
    var outregcap = document.getElementById("outregcap");
    outregcap.value = outTotalRegcap;
    //比例
    var tipScale = document.getElementById("tipScale");
    //保留2位小数
    tipScale.innerHTML=(outTotalRegcap / totalRegcap * 100) .toFixed(2)+"%";
  }
  function doSave(){
    document.getElementById("orgAddForm").submit();
  }
</script>
</head>

<body>
<form action="servlet/orgAdd"method="post"id="orgAddForm">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="images/tab_05.gif"><img src="images/311.gif" width="16" height="16" /> <span class="STYLE4">新设外商企业登记-录入</span></td>
        <td width="281" background="images/tab_05.gif"><table border="0" align="right" cellpadding="0" cellspacing="0">
        </table></td>
        <td width="14"><img src="images/tab_07.gif" width="14" height="30" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9" background="images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68" >
          <tr>
            <td width="100" height="26" class="STYLE1" colspan="4"><div align="center" style="padding:5px" class="STYLE2 STYLE1"><font color="#FFFFFF"><B>企业基本信息</B></font></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">组织机构代码:</div></td><%--${param.username} 相当于 request.getParameter("username")。--%>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2">${param.orgcode}<input type="hidden" name="orgcode" value="<%=request.getParameter("orgcode")%>"/></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">外汇登记证号:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="regno" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">企业中文名称:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="cnname" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">企业英文名称:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="enname" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">联系人:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="contactman" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">联系电话:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" name="contacttel" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"></div></td>
          </tr>
          <tr>
            <td width="100" height="26" class="STYLE1" colspan="4"><div align="center" width="100%" style="padding:5px" class="STYLE2 STYLE1"><font color="#FFFFFF"><B>企业资金情况信息</B></font></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">注册资本:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" readonly="readonly" name="regcap" id="regcap" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">注册币种:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2">
		      <select name="regcry" style="WIDTH:100px">
		        <option value=""></option>
		        <option value="000">美元</option>
                <option value="002">日元</option>

		      </select> <font color="red">*</font></div></td>
          </tr>
          <tr>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">外方注册资本:</div></td>
            <td width="250" bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2"><input type="text" readonly="readonly" name="outregcap" id="outregcap" style="width:150px; height:20px; border:solid 1px #035551; color:#000000"><font color="red">*</font></div></td>
            <td width="100" bgcolor="#FFFFFF" height="26" class="STYLE1"><div align="right" style="padding:5px" class="STYLE2 STYLE1">外方出资比例:</div></td>
            <td bgcolor="#FFFFFF" class="STYLE1"><div align="left" style="padding:2px" class="STYLE2" id="tipScale">0%</div></td>
          </tr>
          <tr>
            <td width="100" height="26" class="STYLE1" colspan="4"><div align="center" style="padding:5px" class="STYLE2 STYLE1"><font color="#FFFFFF"><B>投资者资金及利润分配</B></font></div></td>
          </tr>
          <tr>
            <td width="100%" bgcolor="#FFFFFF" class="STYLE1" colspan="4">
                <table border="0" id="invListTable" width="100%" height="100%" cellpadding="0" cellspacing="1" bgcolor="#0e6f68">
		          <tr>
		            <td width="20%" bgcolor="#CCCCCC" height="20" class="STYLE1"><div align="center" style="padding:5px" class="STYLE2 STYLE1">投资者名称</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1"><div align="center" style="padding:2px" class="STYLE2">国别</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1"><div align="center" style="padding:5px" class="STYLE2 STYLE1">注册资本出资额</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1"><div align="center" style="padding:2px" class="STYLE2">利润分配比例</div></td>
		            <td width="20%" bgcolor="#CCCCCC" class="STYLE1">
                      <div align="center" style="padding:2px" class="STYLE2">
                        <%--Window.open()：打开一个新窗口window.open(url, [name], [configuration])其中：
                          url：为要新打开页面的url name：为新打开窗口的名字，可以通过此名字获取该窗口对象 configuration：为新打开窗口的一些配置项，比如是否有菜单栏、滚动条、长高等等信息--%>
                        <img src="images/query.jpg" onclick="window.open('foreignExchange/orgcodeSelect.jsp', '选择组织机构代码', 'width=720, height=400, scrollbars=no')"/>
                      </div>
                    </td>

		          </tr>

                </table>
            </td>
          </tr>
        </table></td>
        <td width="9" background="images/tab_16.gif">&nbsp;</td>

      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9" background="images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68">
          <tr height="30"><td bgcolor="#FFFFFF" height="30" class="STYLE1" colspan="2" align="center"><img src="images/ok.jpg" onclick="doSave()"/>&nbsp;&nbsp;<img src="images/back.jpg" onclick="document.location='foreignExchange/newInputOrg.jsp'"/></td></tr>
        </table></td>
        <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="29"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="29"><img src="images/tab_20.gif" width="15" height="29" /></td>
        <td background="images/tab_21.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
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
        <td width="14"><img src="images/tab_22.gif" width="14" height="29" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
