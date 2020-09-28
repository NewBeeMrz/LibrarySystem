package service;

import java.util.List;

import entity.Category;



public interface CategoryService {
	//�鼮�����б�
	public List<Category> getCateList();
	
	//�����鼮����
	public int careateCategory(Category category);
	
	//ɾ���鼮����
	public Integer deleteCategory(Integer c_id);
	
	//����id��ѯ������Ϣ
	public Category getCategorybyID(Integer c_id);
	
	//�޸ķ�����Ϣ
	public Integer updateCategory(Category category);
	
	//��ѯ�����б�
	public List<Category> getCsearchList(String search_content);
}
