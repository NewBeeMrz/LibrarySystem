package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import entity.Category;


public interface CategoryDao {
	public List<Category> getCateList();
	public Integer careateCategory(Category category);
	public Integer deleteCategory(Integer c_id);
	public Category getCategorybyID(Integer c_id);
	public Integer updateCategory(Category category);
	public List<Category> getCsearchList(@Param(value="search_content") String search_content);
}
