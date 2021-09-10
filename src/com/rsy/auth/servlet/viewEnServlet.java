package com.rsy.auth.servlet;

import com.rsy.entity.Enterprise;
import com.rsy.service.EnterpriseService;
import com.rsy.serviceImpl.EnterpriseServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 核准件查询企业详细信息
 */
public class viewEnServlet extends HttpServlet {
    private static EnterpriseService en = new  EnterpriseServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orgcode = request.getParameter("Orgcode");

        Enterprise enterprise = en.findByCode(orgcode);

        //转发到试图
        request.setAttribute("en",enterprise);
        request.getRequestDispatcher("/auth/openAccountAuthDetail.jsp").forward(request,response);
    }
}
