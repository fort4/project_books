package com.fort4.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.fort4.interceptor.AdminCheckInterceptor;
import com.fort4.interceptor.AutoLoginInterceptor;
import com.fort4.interceptor.LoginCheckInterceptor;

/*
 * 인터셉터 경로 적용 및 처리 파일
 */
@EnableWebMvc
@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {
    
    @Autowired
    private AdminCheckInterceptor adminCheckInterceptor;

    @Autowired
    private LoginCheckInterceptor loginCheckInterceptor;

    @Autowired
    private AutoLoginInterceptor autoLoginInterceptor;
    
	/*
	 * @PostConstruct public void init() { System.out.println("🚨 WebConfig 로딩됨"); }
	 */

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 자동 로그인 인터셉터: 항상 가장 먼저 실행되도록 등록
        registry.addInterceptor(autoLoginInterceptor)
                .addPathPatterns("/**");
        
        // 일반 로그인 검증
        registry.addInterceptor(loginCheckInterceptor)
                .addPathPatterns("/rental/**", "/mypage/**", "/member/**", "/admin/**")
                .excludePathPatterns(
                		  "/", "/index",
                		  "/member/login", "/member/signup", "/member/logout", "/member/find-id",
                		  "/resources/**"
                		);

        // 관리자 권한 검증
        registry.addInterceptor(adminCheckInterceptor)
                .addPathPatterns("/admin/**")
                .excludePathPatterns("/login", "/resources/**");
    }
}
