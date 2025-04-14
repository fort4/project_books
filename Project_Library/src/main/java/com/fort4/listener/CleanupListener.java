package com.fort4.listener;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class CleanupListener implements ServletContextListener {
	
	@Override
    public void contextInitialized(ServletContextEvent sce) {
		// 앱 시작시 작업X -> 비워둠
    }
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
	    try {
	        AbandonedConnectionCleanupThread.checkedShutdown();
	        System.out.println("정상 종료");
	    } catch (Exception e) {
	        System.err.println("스레드 종료 실패: " + e.getMessage());
	    }
	}

    
}
