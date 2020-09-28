package service;

import java.util.List;

import entity.Category;



public interface CategoryService {
	//书籍分类列表
	public List<Category> getCateList();
	
	//创建书籍分类
	public int careateCategory(Category category);
	
	//删除书籍分类
	public Integer deleteCategory(Integer c_id);
	
	//根据id查询分类信息
	public Category getCategorybyID(Integer c_id);
	
	//修改分类信息
	public Integer updateCategory(Category category);
	
	//查询分类列表
	public List<Category> getCsearchList(String search_content);
}
