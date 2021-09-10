package com.rsy.dao;

import com.rsy.entity.Auth;

import java.sql.SQLException;
import java.util.Map;

/**
 * 核准件
 */
public interface AuthDao {
    /**
     * 添加核准件
     * @param authMap
     * @return
     * @throws SQLException
     */
    int saveAuth(Map<String,String> authMap) throws SQLException;

    /**
     * 查询核准件
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
