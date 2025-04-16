package com.fort4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

@Controller
public class ImageUploadController {

	// 업로드 크기 일단 5MB
    private static final long MAX_SIZE = 5 * 1024 * 1024;
    // 확장자 제한
    private static final List<String> ALLOWED_EXTENSIONS = Arrays.asList(".jpg", ".jpeg", ".png");

    @PostMapping("/upload/image")
    @ResponseBody
    public Map<String, Object> uploadImage(@RequestParam("uploadFile") MultipartFile file,
                                           HttpServletRequest request) {

        Map<String, Object> response = new HashMap<>();

        if (file.isEmpty()) {
            response.put("success", false);
            response.put("message", "파일이 비어 있습니다.");
            response.put("url", "/resources/images/no-image.jpg");
            return response;
        }
        
        // 파일 크기 체크
        if (file.getSize() > MAX_SIZE) {
            response.put("success", false);
            response.put("message", "파일 크기는 5MB 이하만 가능합니다.");
            return response;
        }

        String originalName = file.getOriginalFilename();
        String ext = originalName.substring(originalName.lastIndexOf(".")).toLowerCase();

        if (!ALLOWED_EXTENSIONS.contains(ext)) {
            response.put("success", false);
            response.put("message", "jpg, jpeg, png 확장자만 업로드 가능합니다.");
            return response;
        }

        try {
            String uploadPath = request.getServletContext().getRealPath("/resources/images");
            String uuid = UUID.randomUUID().toString();
            String savedName = uuid + ext;

            File saveFile = new File(uploadPath, savedName);
            file.transferTo(saveFile);

            response.put("success", true);
            response.put("url", "/resources/images/" + savedName);
            return response;

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "서버 오류로 업로드에 실패했습니다.");
            return response;
        }
    }
}
