<%@ page import="com.rsy.entity.Enterprise" %>
<%@ page import="com.rsy.entity.Page" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <script type="text/javascript" src="clander/date.js"></script>
    <script type="text/javascript" src="clander/setday.js"></script>
    <script language="JavaScript" src="JS-jar/FusionCharts.js"></script>
    <script>document.onclick=function() {}</script>
    <title>外商投资企业选择</title>
    <%
        Page<Enterprise> pageObj= (Page<Enterprise>) request.getAttribute("page");
        List<Enterprise> enList = null;
        int pageCount = 0;
        int totalsize = 0;
        int pagesize = 0;
        int pageno = 0;
        if (pageObj != null){
            //用户列表信息
            enList =pageObj.getDataList();
            //总页数
            pageCount = pageObj.getPageCount();
            //总记录数
            totalsize = pageObj.getTotalsize();
            //每页显示的记录条数
            pagesize = pageObj.getPagesize();
            //第几页
            pageno   = pageObj.getPageno();
        }

    %>

    <style type="text/css">

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


</style>

<script>
  function pageQueryEn(){
    document.getElementById("enForm").submit();
  }
  /* 改变页数*/
  function changePage(pageno) {
      //document.location="/egov/pageQueryInv?pageno="+pageno;
      var obj = document.getElementById("enForm");
      obj.action = "servlet/pageQueryEn?pageno="+pageno;
      obj.submit();
  }

  /*跳转到第几页*/
  function pagenum(pagecount){
      var pageNum = document.getElementById("pageNum");
      var pageno = pageNum.value.trim();

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
      //var pageno = parseInt(pageno);//js将字符串转为number
      if (pageno > pagecount){

          changePage(pagecount);
          return;
      }
      if (pageno <=0){

          changePage(1);
          return;
      }

      changePage(pageno);

    function displagChart(orgcode){
        var chart = new FusionCharts("Swf/FCF_Pie2D.swf", "ChartId", "500", "369");
        /*chart.setDataURL("XML/Pie2D.xml");*/
        chart.setDataURL("/servlet/charXml?orgcode="+orgcode);
        chart.render("chartdiv");
    }
    function clearChart(){
        document.getElementById("chartdiv").innerText = "";
    }

  }
</script>
</head>

<body>
<div id="chartdiv" style="position: absolute;top: auto;left: auto "></div>
<form action="servlet/pageQueryEn" method="post" name="enForm" id="enForm">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="30"><img src="images/tab_03.gif" width="15" height="30" /></td>
        <td width="1101" background="images/tab_05.gif"><img src="images/311.gif" width="16" height="16" /> <span class="STYLE4">外商投资企业列表</span></td>
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
        	        <td width="120" class="STYLE1">组织机构代码:</td>
        	        <td width="140" class="STYLE1"><input type="text" value="${param.orgcode}" name="orgcode" style="width:100px; height:20px; border:solid 1px #035551; color:#000000"></td>
        	        <td width="90" class="STYLE1">企业中文名称:</td>
        	        <td width="130" class="STYLE1" ><input type="text" value="${param.cnname}" name="cnname" style="width:100px; height:20px; border:solid 1px #035551; color:#000000"></td>
				    <td width="60"  nowrap class="STYLE1">登记日期:</td>
				    <td class="class1_td alignleft" nowrap>
				        <input type="text" value="${param.startdate}" name="startdate" style="width:75px; height:20px; border:solid 1px #035551; color:#000000" readonly>
				        <input onclick="setday(document.all.startdate);" type="image" value=" 选择日期 " name="button004" src="clander/clander.gif" align="top"/>
				  ～
				  <input type="text" name="enddate" value="${param.enddate}" style="width:75px; height:20px; border:solid 1px #035551; color:#000000" readonly>
				  <input onclick="setday(document.all.enddate);" type="image" value=" 选择日期 " name="button004" src="clander/clander.gif" align="top"/>
				      </td> 
        	    </tr>
        	    <tr>
        	        <td class="STYLE1" colspan="5" align="left"></td>
        	        <td nowrap class="STYLE1" align="right"><button style="width:68px;height:27px" onclick="pageQueryEn()" ><img src="images/query.jpg" /></button>&nbsp;&nbsp;<button style="width:68px;height:27px"><img src="images/clear.jpg" /></button>&nbsp;&nbsp;</td>
        	    </tr>
        	</table>
        </td>
        <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
      <tr height="10">
          <td width="9" background="images/tab_12.gif">&nbsp;</td>
          <td bgcolor="#f3ffe3">&nbsp;</td>
          <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
  </table>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="9" background="images/tab_12.gif">&nbsp;</td>
        <td bgcolor="#f3ffe3"><table width="99%" id="dataTable" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68" >
        <thead class="class1_thead">
          <tr>
            <td width="8%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">序号</div></td>
            <td width="20%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">组织机构代码</div></td>
            <td width="24%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2">企业中文名称</div></td>
            <td width="10%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">登记日期</div></td>
            <td width="8%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">经办人</div></td>
            <td width="8%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">投资比例</div></td>
          </tr>
          </thead>
          <tbody id="dataTableBody" >
          <c:if test="${not empty page.dataList}">
              <c:forEach items="${page.dataList}" var="en" varStatus="enStatus">
                  <tr>
                      <td height="18" bgcolor="#FFFFFF" class="STYLE2"><div align="center" class="STYLE2 STYLE1">${enStatus.count}</div></td>
                      <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"  style="cursor:hand" onclick="window.opener.addOrgcode('${en.orgcode}');window.close();">${en.orgcode}</div></td>
                      <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${en.cnname}</div></td>
                      <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${en.regdate}</div></td>
                      <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1">${en.username}</div></td>
                      <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1" onclick="displagChart('${en.orgcode}')" style="cursor: hand" onmouseout="clearChart()">详细</div></td>
                  </tr>
              </c:forEach>
          </c:if>
          <%--<%
              int i =0;
              if (enList != null){
                  for (Enterprise en:enList) {
          %>
          <tr>
            <td height="18" bgcolor="#FFFFFF" class="STYLE2"><div align="center" class="STYLE2 STYLE1"><%=++i%></div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"  style="cursor:hand" onclick="window.opener.addOrgcode('<%=en.getOrgcode()%>');window.close();"><%=en.getOrgcode()%></div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"><%=en.getCnname()%></div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"><%=en.getRegdate()%></div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"><%=en.getUsername()%></div></td>
            <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1" onclick="displagChart('<%=en.getOrgcode()%>')" style="cursor: hand" onmouseout="clearChart()">详细</div></td>
          </tr>
          <%
                  }
              }
          %>--%>

          </tbody>
        </table></td>
        <td width="9" background="images/tab_16.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
      <%
          boolean isStartPage = pageno > 1;
          boolean isEndPage =pageno < pageCount;
      %>
    <td height="29"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" height="29"><img src="images/tab_20.gif" width="15" height="29" /></td>
        <td background="images/tab_21.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="25%" height="29" nowrap="nowrap">
                <span class="STYLE1">共${requestScope.page.totalsize}条纪录，当前第${requestScope.page.pageno}/${requestScope.page.pageCount}页，每页最多${requestScope.page.pagesize}条纪录</span>
            </td>
            <td width="75%" valign="top" class="STYLE1"><div align="right">
              <table width="352" height="20" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/firstPage<%=isStartPage? "":"Disabled"%>.gif"<%=isStartPage? "style='cursor:pointer'onclick='changePage(1)'":""%> /></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/prevPage<%=isStartPage? "":"Disabled"%>.gif" <%=isStartPage? "style='cursor:pointer' onclick='changePage("+(pageno - 1)+")'":""%> /></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/nextPage<%=isEndPage? "":"Disabled"%>.gif" <%=isEndPage? "style='cursor:pointer' onclick='changePage("+(pageno + 1)+")'":""%>/></div></td>
                  <td width="30" height="22" valign="middle"><div align="right"><img src="images/lastPage<%=isEndPage? "":"Disabled"%>.gif" <%=isEndPage? "style='cursor:pointer' onclick='changePage("+pageCount+")'":""%>/></div></td>
                  <td width="59" height="22" valign="middle"><div align="right" class="STYLE2 STYLE1">转到第</div></td>
                  <td width="25" height="22" valign="middle"><span class="STYLE7">
                    <input name="textfield" id="pageNum" type="text" class="STYLE1" style="height:20px; width:25px;text-align:right" size="5" />
                  </span></td>
                  <td width="23" height="22" valign="middle" class="STYLE2 STYLE1">页</td>
                  <td width="30" height="22" valign="middle"><img src="images/go.gif" width="37" height="15"  onclick="pagenum(<%=pageCount%>)"/></td>
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
