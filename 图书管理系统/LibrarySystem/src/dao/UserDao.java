package dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import entity.Book;
import entity.User;



public interface UserDao {
	public User findUser(User user);
	public User getUserById(int user_id);
	public int updateUser(User user);
	public Integer registerUser(User user);
	public List<User> getUserList(User user);
	public Integer getUserListCount(User user);
	public Integer createUser(User user);
	public List<User> getSearchList(User user);
	public Integer getSearchListCount(User user);
	public Integer deleteUser(Integer user_id);
}
