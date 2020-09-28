package service;


import java.util.List;

import entity.Book;
import entity.User;
import utils.Page;

public interface UserService {
	public User findUser(User user);
	public User getUser(Integer user_id);
	public int updateUser(User user);
	public Integer registerUser(User user);
	public Page<User> getUserList(Integer page, Integer rows);
	public Integer createUser(User user);
	public Page<User> getSearchList(Integer user_rank,String search_content,Integer page, Integer rows);
	public Integer deleteUser(Integer user_id);
}
