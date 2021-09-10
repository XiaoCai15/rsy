package com.rsy.authResponse.servlet;

import com.rsy.service.AuthService;
import com.rsy.serviceImpl.AuthServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 更新反馈信息
 */
public class UpdateServlet extends HttpServlet {
    private static AuthService authService = new AuthServiceImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String authno = request.getParameter("authno");
        int count = authService.upFeedBack(authno);
        if (count == 1){
            response.sendRedirect("/egov/authresponse/authResponseList.jsp");
        }else {
            String error = "反馈失败，请重新进行反馈";
            request.setAttribute("error",error);
            request.getRequestDispatcher("/authresponse/authResponseView.jsp").forward(request,response);
        }

    }

}
