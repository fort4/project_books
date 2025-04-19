package com.fort4.listener;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * 드라이버 해제용
 * @author core
 *
 */
@WebListener
public class CleanupListener implements ServletContextListener {
	
	@Override
    public void contextInitialized(ServletContextEvent sce) {
		// 앱 시작시 별도 동작없슴
    }
	
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // 1. JDBC 드라이버 해제
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                System.out.println("✅ JDBC 드라이버 해제됨: " + driver);
            } catch (SQLException e) {
                System.err.println("❌ 드라이버 해제 실패: " + driver + " : " + e.getMessage());
            }
        }

        // 2. MySQL cleanup thread 종료
        try {
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("✅ MySQL CleanupThread 정상 종료");
        } catch (Throwable t) {
            System.err.println("❌ CleanupThread 종료 실패: " + t);
        }
    }
    
}
