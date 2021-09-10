package com.rsy.Servlet;

import com.rsy.entity.Users;
import com.rsy.util.JdbcUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

/**
 * 登陆系统
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean flag = false;
        HttpSession session =  request.getSession();
        JdbcUtil util = new JdbcUtil();
        Users user = new Users();

        request.setCharacterEncoding("UTF-8");
        String orgtype =  request.getParameter("orgtype");
        String usercode = request.getParameter("usercode");
        String userpswd = request.getParameter("userpswd");



        try {
            String sql = "select username from t_user where usercode=? and orgtype=? and userpswd=?";
            ps = util.createStatement(sql);
            ps.setString(1,usercode);
            ps.setString(2,orgtype);
            ps.setString(3,userpswd);
            rs = ps.executeQuery();
            if (rs.next()){
                user.setUsername(rs.getString("username"));
                user.setUsercode(usercode);
                user.setOrgtype(orgtype);
                user.setUserpswd(userpswd);
                session.setAttribute("user",user);
                flag = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (flag){
            request.getRequestDispatcher("/main.html").forward(request,response);
        }else {
            String errorMsg = "登陆失败，请从新填写";
            request.setAttribute("errorMsg",errorMsg);
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }
    }
}
