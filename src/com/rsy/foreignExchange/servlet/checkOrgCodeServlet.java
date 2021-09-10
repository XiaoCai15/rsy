package com.rsy.foreignExchange.servlet;

import com.rsy.util.JdbcUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 验证企业组织是否存在
 */
public class checkOrgCodeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orgcode = request.getParameter("orgcode");
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean flag = false;
        JdbcUtil util = new JdbcUtil();
        String sql = "select * from t_enterprise where orgcode = ?";
        try {
            ps = util.createStatement(sql);
            ps.setString(1,orgcode);
            rs = ps.executeQuery();
            if (rs.next()){
                flag = true;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }finally {
            util.close(rs);
        }
        response.setContentType("text/html;charset=UTF-8");
        if (flag){
           /* PrintWriter out = response.getWriter();
            out.println("<font color='red'>该组织机构已存在</font>");*/
            String errorMsg = "组织机构已存在，请从新填写";
            request.setAttribute("errorMsg",errorMsg);
            request.getRequestDispatcher("/foreignExchange/newInputOrg.jsp").forward(request,response);
        }else {
            request.getRequestDispatcher("/foreignExchange/inputOrgInfo.jsp").forward(request,response);
        }
    }
}
