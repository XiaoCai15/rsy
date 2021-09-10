package com.rsy.service;

import com.rsy.entity.Auth;

import java.util.Map;

/**
 * 核准件
 */
public interface AuthService {
    /**
     * 添加核准件
     * @param authMap
     * @return
     */
    boolean saveAuth(Map<String,String> authMap);

    /**
     * 查询
     * @param authno
     * @return
     */
    Auth findByAuthno(String authno);

    /**
     * 更新反馈信息
     * @param authno
     * @return
     */
    int upFeedBack(String authno);
}
