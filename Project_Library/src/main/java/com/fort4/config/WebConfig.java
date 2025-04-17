package com.fort4.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.fort4.interceptor.AdminCheckInterceptor;
import com.fort4.interceptor.AutoLoginInterceptor;
import com.fort4.interceptor.LoginCheckInterceptor;
import com.fort4.mapper.MemberMapper;
import com.fort4.mapper.RememberTokenMapper;

/*
 * 인터셉터 경로 적용 및 처리 파일
 */
@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {
	
    @Autowired
    private MemberMapper memberMapper;
    
    @Autowired
    private RememberTokenMapper rememberTokenMapper;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 자동 로그인 인터셉터: 항상 가장 먼저 실행되도록 등록
        registry.addInterceptor(new AutoLoginInterceptor(memberMapper, rememberTokenMapper))
                .addPathPatterns("/**");
        
        // 일반 로그인 검증
        registry.addInterceptor(new LoginCheckInterceptor())
                .addPathPatterns("/books/**", "/rental/**", "/mypage/**")
                .excludePathPatterns("/", "/index", "/login", "/signup", "/logout", "/resources/**");

        // 관리자 권한 검증
        registry.addInterceptor(new AdminCheckInterceptor())
                .addPathPatterns("/admin/**")
                .excludePathPatterns("/login", "/resources/**");
    }
}
