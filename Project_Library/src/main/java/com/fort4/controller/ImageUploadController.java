package com.fort4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ImageUploadController {

    @PostMapping("/upload/image")
    @ResponseBody
    public String uploadImage(@RequestParam("uploadFile") MultipartFile file,
                               HttpServletRequest request) {
        if (file.isEmpty()) {
            return "/resources/images/no-image.jpg"; // 기본 이미지
        }

        try {
            String uploadPath = request.getServletContext().getRealPath("/resources/images");
            String originalName = file.getOriginalFilename();
	        // 1. 파일 확장자 추출
	        String ext = originalName.substring(originalName.lastIndexOf("."));
	        // 2. 안전한 저장 이름 생성(공백, 특문 사용시 업로드 오류 나서)
	        String uuid = UUID.randomUUID().toString();
	        String savedName = uuid + ext;

            File saveFile = new File(uploadPath, savedName);
            file.transferTo(saveFile);

            return "/resources/images/" + savedName;
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR";
        }
    }
}
