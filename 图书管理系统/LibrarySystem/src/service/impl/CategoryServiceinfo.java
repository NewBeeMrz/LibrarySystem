package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.CategoryDao;
import entity.Category;
import service.CategoryService;

@Service("categoryService")
@Transactional
public class CategoryServiceinfo implements CategoryService{
	// 声明DAO属性并注入
	@Autowired
	private CategoryDao categoryDao;
	
	@Override
	public List<Category> getCateList() {
		List<Category> list=categoryDao.getCateList();
//		System.out.println("===list======"+list);
		return list;
	}

	@Override
	public int careateCategory(Category category) {
		// TODO Auto-generated method stub
		return this.categoryDao.careateCategory(category);
	}

	@Override
	public Integer deleteCategory(Integer c_id) {
		// TODO Auto-generated method stub
		return this.categoryDao.deleteCategory(c_id);
	}

	@Override
	public Category getCategorybyID(Integer c_id) {
		// TODO Auto-generated method stub
		return this.categoryDao.getCategorybyID(c_id);
	}

	@Override
	public Integer updateCategory(Category category) {
		// TODO Auto-generated method stub
		return this.categoryDao.updateCategory(category);
	}

	@Override
	public List<Category> getCsearchList(String search_content) {
		// TODO Auto-generated method stub
		return this.categoryDao.getCsearchList(search_content);
	}

}
