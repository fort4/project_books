package com.fort4.controller.api;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.fort4.utill.FileStorageService;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/upload")
@RequiredArgsConstructor
public class ImageUploadController {

    private final FileStorageService fileStorageService;

    @PostMapping("/image")
    public Map<String, Object> uploadImage(@RequestParam("uploadFile") MultipartFile file) {
        Map<String, Object> res = new HashMap<>();
        try {
            String url = fileStorageService.store(file);
            res.put("success", true);
            res.put("url", url);
        } catch (Exception e) {
            res.put("success", false);
            res.put("message", e.getMessage());
        }
        return res;
    }
}
