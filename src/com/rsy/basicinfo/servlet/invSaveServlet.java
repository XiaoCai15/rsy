package com.rsy.basicinfo.servlet;

import com.rsy.entity.Invest;
import com.rsy.entity.Users;
import com.rsy.util.Const;
import com.rsy.util.DateUtil;
import com.rsy.util.JdbcUtil;
import com.rsy.util.WebUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;

/**
 * 新建投资人
 */
public class invSaveServlet extends HttpServlet {
 @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     PreparedStatement ps = null;
     int rs = 0;
     JdbcUtil util = new JdbcUtil();

     request.setCharacterEncoding("UTF-8");
     //String invregnum  = request.getParameter("invregnum");
  /*  String invname    = request.getParameter("invname");
    String city       = request.getParameter("city");
    String orgcode    = request.getParameter("orgcode");
    String contactman = request.getParameter("contactman");
    String contacttel = request.getParameter("contacttel");
    String email      = request.getParameter("email");
    String remark     = request.getParameter("remark");*/
     Invest inv = new Invest();
     WebUtil.makeRequestToObject(request,inv);
    String usercode   = ((Users)request.getSession().getAttribute("user")).getUsercode();
    String regdate    = DateUtil.format(new Date(),Const.DATE_FORMAT_YMD);

     try {
         String sql = "insert into t_invest(invname,city,orgcode,contactman,contacttel,email,remark,usercode,regdate) values(?,?,?,?,?,?,?,?,?)";
         ps = util.createStatement(sql);
         ps.setString(1,inv.getInvname());
         ps.setString(2,inv.getCity());
         ps.setString(3,inv.getOrgcode());
         ps.setString(4,inv.getContactman());
         ps.setString(5,inv.getContacttel());
         ps.setString(6,inv.getEmail());
         ps.setString(7,inv.getRemark());
         ps.setString(8,usercode);
         ps.setString(9,regdate);
         rs = ps.executeUpdate();
     } catch (SQLException throwables) {
         throwables.printStackTrace();
     }
     if (rs == 1){
         response.sendRedirect("basicinfo/exoticOrgList.jsp");
     }
 }
}
