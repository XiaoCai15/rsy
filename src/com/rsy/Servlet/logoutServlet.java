package com.rsy.Servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 退出系统
 */
public class logoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);//判断是否有session对象
        if(session != null){
            session.invalidate();/*杀死session*/
        }
         response.sendRedirect("login.jsp");/*重定向不需要加"/"*/
    }


}
