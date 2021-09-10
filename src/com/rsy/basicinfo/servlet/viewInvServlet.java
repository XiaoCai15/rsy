package com.rsy.basicinfo.servlet;

import com.rsy.entity.Invest;
import com.rsy.util.JdbcUtil;
import com.rsy.util.StringUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class viewInvServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        PreparedStatement ps = null;
        ResultSet rs = null;
        JdbcUtil util = new JdbcUtil();
        Invest invest = new Invest();
        String invregnum = request.getParameter("Invregnum");

        String sql = "select * from t_invest where invregnum = ?";
        try {
           ps = util.createStatement(sql);
           ps.setString(1,invregnum);
           rs = ps.executeQuery();
          if (rs.next()){

               invest.setInvname(rs.getString("invname"));
               invest.setCity(StringUtil.getTextBycode(rs.getString("city")));
               invest.setOrgcode(rs.getString("orgcode"));
               invest.setContactman(rs.getString("contactman"));
               invest.setContacttel(rs.getString("contacttel"));
               invest.setEmail(rs.getString("email"));
               invest.setRemark(rs.getString("remark"));

           }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            util.close(rs);
        }
        request.setAttribute("invest",invest);
        request.getRequestDispatcher("/basicinfo/exoticOrgView.jsp").forward(request,response);

    }

}
