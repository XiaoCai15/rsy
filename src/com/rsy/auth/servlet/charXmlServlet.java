package com.rsy.auth.servlet;

import com.rsy.dao.EnterpriseDao;
import com.rsy.service.EnterpriseService;
import com.rsy.serviceImpl.EnterpriseServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * FushionCharts进行统计图表（已过时不被浏览器支持）编写xml字符串
 */
public class charXmlServlet extends HttpServlet {
    private static EnterpriseService en = new EnterpriseServiceImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orgcode = request.getParameter("orgcode");
        //调用Model
        String charXml = en.makeCharXml(orgcode);


        //展示
        response.setContentType("text/xml;charset=UTF-8");
        response.getWriter().println(charXml);
    }


}
