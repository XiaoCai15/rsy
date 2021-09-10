package com.rsy.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CheckLoginFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest)request;
        HttpServletResponse res = (HttpServletResponse) response;
        //获取是否有session
         HttpSession session = req.getSession(false);
        /*  request.getRequestURL() 返回全路径
            request.getRequestURI() 返回除去host（域名或者ip）部分的路径
            request.getContextPath() 返回工程名部分，如果工程映射为/，此处返回则为空
            request.getServletPath() 返回除去host和工程名部分的路径*/




            String path = req.getServletPath();
            //String uri = req.getRequestURI();
            System.out.println(path);
            //if(uri.indexOf("login.jsp")!=-1 || "/egov/".equals(uri) || (session != null && session.getAttribute("user") != null)){
            if ("/login.jsp".equals(path)||"/servlet/login".equals(path)||(session != null && session.getAttribute("user") != null)){
                chain.doFilter(request, response);
            }else {

                res.sendRedirect("/egov/login.jsp");
            }

    }
}
