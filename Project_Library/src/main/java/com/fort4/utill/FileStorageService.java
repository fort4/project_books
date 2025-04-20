package com.fort4.utill;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * 비즈니스 로직 처리(서비스임)
 * 등록/수정/삭제 등에서 재사용
 * @author core
 *
 */
@Service
@RequiredArgsConstructor
public class FileStorageService {

    private final ServletContext servletContext;
    private static final long MAX_SIZE = 5 * 1024 * 1024;
    private static final String UPLOAD_DIR = "/resources/images/books";
    private static final String[] ALLOWED_EXTENSIONS = {".jpg", ".jpeg", ".png"};

    /** MultipartFile을 저장하고, URL 경로를 반환. JSP쪽에서 경로 조립하게 설계 */
    public String store(MultipartFile file) {
    	// ---------------유효성 검사--------------
        if (file.isEmpty()) {
            throw new IllegalArgumentException("파일이 비어 있습니다.");
        }
        if (file.getSize() > MAX_SIZE) {
            throw new IllegalArgumentException("파일 크기는 5MB 이하만 가능합니다.");
        }
        String original = file.getOriginalFilename();
        String ext = original.substring(original.lastIndexOf(".")).toLowerCase();
        boolean ok = false;
        for (String allow : ALLOWED_EXTENSIONS) {
            if (allow.equals(ext)) {
                ok = true;
                break;
            }
        }
        if (!ok) {
            throw new IllegalArgumentException("jpg, jpeg, png 확장자만 업로드 가능합니다.");
        }
        // ----------------유효성 검사---------------
        
        // 1. 실제 디스크 경로 확인
        String realPath = servletContext.getRealPath(UPLOAD_DIR);
        System.out.println("▶ FileStorageService realPath: " + realPath);
        
        // 2. 디렉토리 생성
        File destDir = new File(realPath);
        System.out.println("▶ destDir.exists() 전: " + destDir.exists());
        if (!destDir.exists()) {
        	destDir.mkdirs();  // 폴더 없을시 자동 생성
        	System.out.println("▶ destDir.mkdirs() 결과: " + ok);
        }
        System.out.println("▶ destDir.exists() 후: " + destDir.exists());
        
        // 3. 저장할 파일 경로
        String uuid = UUID.randomUUID().toString();
        String fileExt = file.getOriginalFilename()
                .substring(file.getOriginalFilename().lastIndexOf("."))
                .toLowerCase();
        String savedName = uuid + fileExt;
        File dest = new File(realPath, savedName);
        System.out.println("▶ 저장 대상 파일: " + dest.getAbsolutePath());
        dest.getParentFile().mkdirs();
        try {
            file.transferTo(dest);
        } catch (IOException e) {
            throw new RuntimeException("파일 업로드 중 오류가 발생했습니다.", e);
        }
        // 반환되는 url(UPLOAD_DIR + "/" 지우고 이름만 리턴하게)
        return savedName;
    }

    /** 이미지 URL을 받아 실제 파일을 삭제 */
    public void delete(String imageUrl) {
        if (imageUrl == null || imageUrl.isEmpty()) return;
        String realPath = servletContext.getRealPath(imageUrl);
        File f = new File(realPath);
        if (f.exists()) f.delete();
    }
}
