package service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dao.BookDao;
import dao.BorrowDao;
import entity.Book;
import entity.Borrowtable;
import service.BorrowService;
import utils.Page;

@Service("borrowService")
@Transactional
public class BorrowServiceinfo implements BorrowService{
	// 声明DAO属性并注入
	@Autowired
	private BorrowDao borrowDao;

	@Override
	public Page<Borrowtable> getborrowtableByUser(Integer user_id, Integer page, Integer rows) {
		// 创建图书对象
		Borrowtable borrowtable = new Borrowtable();

		// 当前页
		borrowtable.setStart((page-1) * rows) ;
		// 每页数
		borrowtable.setRows(rows);
		
		borrowtable.setUser_id(user_id);
		// 查询图书列表
		List<Borrowtable> borrowtables = 
				borrowDao.getborrowtableByUser(borrowtable);
		// 查询商品列表总记录数
		Integer count = borrowDao.getborrowtableByUserCount(borrowtable);
		// 创建Page返回对象
		Page<Borrowtable> result = new Page<>();
		result.setPage(page);
		result.setRows(borrowtables);
		result.setSize(rows);
		result.setTotal(count);
		return result;
	}

	@Override
	public Page<Borrowtable> getSearchList(Integer user_id, Integer page, Integer rows,String search_date,String status,String search_content) {
		// 创建图书对象
				Borrowtable borrowtable = new Borrowtable();

				// 当前页
				borrowtable.setStart((page-1) * rows) ;
				// 每页数
				borrowtable.setRows(rows);
				
				borrowtable.setUser_id(user_id);
				borrowtable.setSearch_date(search_date);
				borrowtable.setStatus(status);
				borrowtable.setSearch_content(search_content);
				// 查询图书列表
				List<Borrowtable> borrowtables = 
						borrowDao.getSearchList(borrowtable);
				// 查询商品列表总记录数
				Integer count = borrowDao.getSearchListCount(borrowtable);
				// 创建Page返回对象
				Page<Borrowtable> result = new Page<>();
				result.setPage(page);
				result.setRows(borrowtables);
				result.setSize(rows);
				result.setTotal(count);
				return result;
	}

	@Override
	public Page<Borrowtable> getBorrowtableList(Integer page, Integer rows) {
		// 创建借阅记录对象
		Borrowtable borrowtable = new Borrowtable();

		// 当前页
		borrowtable.setStart((page-1) * rows) ;
		// 每页数
		borrowtable.setRows(rows);
		// 查询图书列表
		List<Borrowtable> borrowtables = borrowDao.getBorrowtableList(borrowtable);
		// 查询商品列表总记录数
		Integer count = borrowDao.getBorrowtableListCount(borrowtable);
		// 创建Page返回对象
		Page<Borrowtable> result = new Page<>();
		result.setPage(page);
		result.setRows(borrowtables);
		result.setSize(rows);
		result.setTotal(count);
		return result;
	}

	@Override
	public Integer createBorrow(Borrowtable borrowtable) {
		// TODO Auto-generated method stub
		return this.borrowDao.createBorrow(borrowtable);
	}

	@Override
	public Integer returnBook(Borrowtable borrowtable) {
		// TODO Auto-generated method stub
		return this.borrowDao.returnBook(borrowtable);
	}

}
