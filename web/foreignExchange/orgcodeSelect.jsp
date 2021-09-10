<%@ page import="com.rsy.entity.Invest" %>
<%@ page import="com.rsy.entity.Page" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rsy.util.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<html>
<head>
  <base href="<%=basePath%>">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <script type="text/javascript" src="clander/date.js"></script>
  <script type="text/javascript" src="clander/setday.js"></script>
  <script>
    document.onclick=function() {}
  </script>
  <title>投资人选择</title>
  <%
    Page<Invest> pageObj= (Page<Invest>) request.getAttribute("pageObj");
    List<Invest> investList = null;
    int pageCount = 0;
    int totalsize = 0;
    int pagesize = 0;
    int pageno = 0;
    if (pageObj != null){
      //用户列表信息
      investList =pageObj.getDataList();
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
    function pageQueryInv(){
      /*  document.all获取整个页面的dom对象，返回一个集合，该集合中存放了当前网页中的所有dom对象
      *   document.all.dataTableBody 获取id为dataTableBody的元素
      *   document.all.dataTableBody.style.display='block' 标签的样式
      *   document.all.dataTableBody.style.display='block'
      */

      document.getElementById("InvForm").submit();

    }
    /* 改变页数*/
    function changePage(pageno) {
      //document.location="/egov/pageQueryInv?pageno="+pageno;
      var obj = document.getElementById("InvForm");
      obj.action = "servlet/pageQueryInv?pageno="+pageno;
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
    }
  </script>
</head>

<body>
<form action="servlet/pageQueryInv" name="InvForm" id="InvForm" method="post">
<input type="hidden" name="forward" value="/foreignExchange/orgcodeSelect.jsp">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td height="30"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="15" height="30"><img src="images/tab_03.gif" width="15" height="30" /></td>
          <td width="1101" background="images/tab_05.gif"><img src="images/311.gif" width="16" height="16" /> <span class="STYLE4">企业投资人信息登记列表</span></td>
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
                <td width="120" class="STYLE1">投资人登记编号:</td>
                <td width="140" class="STYLE1"><input type="text" name="invregnum" value="<%=request.getParameter("invregnum") == null ? "":request.getParameter("invregnum")%>" style="width:100px; height:20px; border:solid 1px #035551; color:#000000"></td>
                <td width="90" class="STYLE1">投资人名称:</td>
                <td width="130" class="STYLE1" >
                <%--  <input type="text" value="<%=request.getParameter("invname") == null ? "":request.getParameter("invname")%>" name="invname" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">--%>
                  <input type="text" value="${param.invname}" name="invname" style="width:100px; height:20px; border:solid 1px #035551; color:#000000">
                </td>
                <td width="60"  nowrap class="STYLE1">登记日期:</td>
                <td class="class1_td alignleft" nowrap>
                  <input type="text" name="startdate" value="<%=request.getParameter("startdate") == null ? "":request.getParameter("startdate")%>" style="width:75px; height:20px; border:solid 1px #035551; color:#000000" readonly>
                  <input onclick="setday(document.all.startdate);"  type="image" value=" 选择日期 " name="button004" src="clander/clander.gif" align="top"/>
                  ～
                  <input type="text" name="enddate" value="<%=request.getParameter("enddate") == null ? "":request.getParameter("enddate")%>" style="width:75px; height:20px; border:solid 1px #035551; color:#000000" readonly>
                  <input onclick="setday(document.all.enddate);" type="image" value=" 选择日期 " name="button004" src="clander/clander.gif" align="top"/>
                </td>
              </tr>
              <tr>
                <td class="STYLE1" colspan="5" align="left">&nbsp;&nbsp;</td>
                <td nowrap class="STYLE1" align="right"><img src="images/query.jpg" style="cursor:hand" onclick="pageQueryInv()" />&nbsp;&nbsp;<img src="images/clear.jpg" style="cursor:hand" />&nbsp;&nbsp;</td>
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
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="9" background="images/tab_12.gif">&nbsp;</td>
            <td bgcolor="#f3ffe3">
              <table width="99%" id="dataTable" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#0e6f68" >
                <thead class="class1_thead">
                <tr>
                  <td width="8%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">序号</div></td>
                  <td width="20%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">投资人登记编号</div></td>
                  <td width="24%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2">投资人名称</div></td>
                  <td width="10%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">登记日期</div></td>
                  <td width="8%" height="18" background="images/tab_14.gif" class="STYLE1"><div align="center" class="STYLE2 STYLE1">经办人</div></td>
                </tr>
                </thead>
                <tbody id="dataTableBody">

                <%
                  int i =0;
                  if (investList != null){
                    for (Invest invest:investList) {
                %>

                <tr>
                  <td height="18" bgcolor="#FFFFFF" class="STYLE2"><div align="center" class="STYLE2 STYLE1"><%=++i%></div></td>
                  <td height="18" bgcolor="#FFFFFF">
                    <div align="center" class="STYLE2 STYLE1"  style="cursor:hand" onclick="window.opener.addNewLine('<%=invest.getInvregnum()%>','<%=invest.getInvname()%>','<%=invest.getCity()%>')">
                      <%=invest.getInvregnum()%>
                    </div></td>
                  <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"><%=invest.getInvname()%></div></td>
                  <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"><%=invest.getRegdate()%></div></td>
                  <td height="18" bgcolor="#FFFFFF"><div align="center" class="STYLE2 STYLE1"><%=invest.getUsername()%></div></td>
                </tr>
                <%
                    }
                  }
                %>
                </tbody>
              </table>
            </td>
            <td width="9" background="images/tab_16.gif">&nbsp;</td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td height="29"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="15" height="29"><img src="images/tab_20.gif" width="15" height="29" /></td>
          <td background="images/tab_21.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <%
                boolean isStartPage = pageno > 1;
                boolean isEndPage =pageno < pageCount;
              %>
              <td width="25%" height="29" nowrap="nowrap">
                <span class="STYLE1">共${requestScope.pageObj.totalsize}条纪录，当前第${requestScope.pageObj.pageno}/${requestScope.pageObj.pageCount}页，每页最多${requestScope.pageObj.pagesize}条纪录</span>
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
