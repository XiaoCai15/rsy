package com.rsy.system.servlet;

import com.rsy.service.UserService;
import com.rsy.serviceImpl.UserServiceImpl;
import com.rsy.util.JdbcUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 在新增user之前判断是否已经存在该用户
 */
public class checkUsercodeServlet extends HttpServlet {
    private static  UserService service = new UserServiceImpl();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String  usercode = request.getParameter("usercode");
        boolean flag = service.selectByUsercode(usercode);

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (flag){
                out.print("<font color='red'>用户代码已经存在</font>");
        }else {
            //out.print("<font color='green'>用户代码可以使用/font>");
        }
    }


}
