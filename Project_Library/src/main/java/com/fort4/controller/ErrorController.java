package com.fort4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 에러 처리용 컨트롤러
 * @author core
 *
 */
@Controller
public class ErrorController {
	
	@GetMapping("/403")
	public String forbiddenPage() {
	    return "error/403"; // /WEB-INF/views/error/403.jsp
	}

}
