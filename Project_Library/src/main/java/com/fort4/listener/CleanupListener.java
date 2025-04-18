package com.fort4.listener;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

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
    }
    
}
