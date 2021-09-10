package com.rsy.service;

import com.rsy.entity.Users;

public interface UserService {
    Boolean selectByUsercode(String usercode);
    int save(Users user);
}
