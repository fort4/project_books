package com.fort4.controller.admin;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.fort4.controller.BaseController;
import com.fort4.dto.MemberDTO;

/**
 * 관리자 전용 공통 컨트롤러 (BaseController 상속)
 * - 로그인된 관리자 여부 확인
 * - 관리자 전용 접근 제어 등
 */
public abstract class BaseAdminController extends BaseController {
	
    /**
     * 로그인된 사용자가 관리자 권한을 가지고 있는지 확인
     * @param session 현재 세션
     * @return true: 관리자, false: 비로그인 또는 일반 사용자
     */
    protected boolean checkAdmin(HttpSession session) {
        MemberDTO user = getLoginUser(session);
        return isAdmin(user);
    }
}

