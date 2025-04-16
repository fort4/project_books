package com.fort4.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fort4.dto.CategoryDTO;

public interface CategoryMapper {
    List<CategoryDTO> getAllCategories();
}
