package com.rsy.dao;

import com.rsy.entity.Users;

public interface UserDao {
    /**
     * 判断用户代码是否以存在
     * @param usercode
     * @return null表示用户不存在
     */
    Boolean selectByUsercode(String usercode);

    /**
     * 保存用户信息
     * @param user
     * @return
     */
    int insertUser(Users user);

}
