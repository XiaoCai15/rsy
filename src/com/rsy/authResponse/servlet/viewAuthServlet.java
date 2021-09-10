package com.rsy.authResponse.servlet;

import com.rsy.entity.Auth;
import com.rsy.service.AuthService;
import com.rsy.serviceImpl.AuthServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 查看核准件明细
 */
public class viewAuthServlet extends HttpServlet {
    private static AuthService authService = new AuthServiceImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String authno = request.getParameter("authno");
        Auth auth = authService.findByAuthno(authno);
        request.setAttribute("auth",auth);
        request.getRequestDispatcher("/authresponse/authResponseView.jsp").forward(request,response);
    }

}
