package service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.UserDao;
import entity.Book;
import entity.User;
import service.UserService;
import utils.Page;

@Service("userService")
@Transactional
public class UserServiceInfo implements UserService {
	// 注入UserDao
	@Autowired
	private UserDao userDao;

	@Override
	public User findUser(User user) {
		User result = this.userDao.findUser(user);
		return result;
	}

	@Override
	public User getUser(Integer user_id) {
		User user = this.userDao.getUserById(user_id);
		return user;
	}

	@Override
	public int updateUser(User user) {
		return this.userDao.updateUser(user);
	}

	@Override
	public Integer registerUser(User user) {
		// TODO Auto-generated method stub
		return this.userDao.registerUser(user);
	}

	@Override
	public Page<User> getUserList(Integer page, Integer rows) {
		// 创建图书对象
        User user = new User();

		// 当前页
        user.setStart((page-1) * rows) ;
		// 每页数
        user.setRows(rows);
		// 查询用户列表
		List<User> users = 
				userDao.getUserList(user);
		// 查询商品列表总记录数
		Integer count = userDao.getUserListCount(user);
		// 创建Page返回对象
		Page<User> result = new Page<>();
		result.setPage(page);
		result.setRows(users);
		result.setSize(rows);
		result.setTotal(count);
		return result;
	}

	@Override
	public Integer createUser(User user) {
		// TODO Auto-generated method stub
		return this.userDao.createUser(user);
	}

	@Override
	public Page<User> getSearchList(Integer user_rank, String search_content, Integer page, Integer rows) {
		// 创建用户对象
        User user = new User();

		// 当前页
        user.setStart((page-1) * rows) ;
		// 每页数
        user.setRows(rows);
        
        user.setSearch_content(search_content);
        
        user.setUser_rank(user_rank);
		// 查询图书列表
		List<User> users = 
				userDao.getSearchList(user);
		// 查询商品列表总记录数
		Integer count = userDao.getSearchListCount(user);
		
		// 创建Page返回对象
		Page<User> result = new Page<>();
		result.setPage(page);
		result.setRows(users);
		result.setSize(rows);
		result.setTotal(count);
		return result;
	}

	@Override
	public Integer deleteUser(Integer user_id) {
		// TODO Auto-generated method stub
		return this.userDao.deleteUser(user_id);
	}
}
