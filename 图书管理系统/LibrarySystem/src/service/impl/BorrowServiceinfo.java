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
	// ����DAO���Բ�ע��
	@Autowired
	private BorrowDao borrowDao;

	@Override
	public Page<Borrowtable> getborrowtableByUser(Integer user_id, Integer page, Integer rows) {
		// ����ͼ�����
		Borrowtable borrowtable = new Borrowtable();

		// ��ǰҳ
		borrowtable.setStart((page-1) * rows) ;
		// ÿҳ��
		borrowtable.setRows(rows);
		
		borrowtable.setUser_id(user_id);
		// ��ѯͼ���б�
		List<Borrowtable> borrowtables = 
				borrowDao.getborrowtableByUser(borrowtable);
		// ��ѯ��Ʒ�б��ܼ�¼��
		Integer count = borrowDao.getborrowtableByUserCount(borrowtable);
		// ����Page���ض���
		Page<Borrowtable> result = new Page<>();
		result.setPage(page);
		result.setRows(borrowtables);
		result.setSize(rows);
		result.setTotal(count);
		return result;
	}

	@Override
	public Page<Borrowtable> getSearchList(Integer user_id, Integer page, Integer rows,String search_date,String status,String search_content) {
		// ����ͼ�����
				Borrowtable borrowtable = new Borrowtable();

				// ��ǰҳ
				borrowtable.setStart((page-1) * rows) ;
				// ÿҳ��
				borrowtable.setRows(rows);
				
				borrowtable.setUser_id(user_id);
				borrowtable.setSearch_date(search_date);
				borrowtable.setStatus(status);
				borrowtable.setSearch_content(search_content);
				// ��ѯͼ���б�
				List<Borrowtable> borrowtables = 
						borrowDao.getSearchList(borrowtable);
				// ��ѯ��Ʒ�б��ܼ�¼��
				Integer count = borrowDao.getSearchListCount(borrowtable);
				// ����Page���ض���
				Page<Borrowtable> result = new Page<>();
				result.setPage(page);
				result.setRows(borrowtables);
				result.setSize(rows);
				result.setTotal(count);
				return result;
	}

	@Override
	public Page<Borrowtable> getBorrowtableList(Integer page, Integer rows) {
		// �������ļ�¼����
		Borrowtable borrowtable = new Borrowtable();

		// ��ǰҳ
		borrowtable.setStart((page-1) * rows) ;
		// ÿҳ��
		borrowtable.setRows(rows);
		// ��ѯͼ���б�
		List<Borrowtable> borrowtables = borrowDao.getBorrowtableList(borrowtable);
		// ��ѯ��Ʒ�б��ܼ�¼��
		Integer count = borrowDao.getBorrowtableListCount(borrowtable);
		// ����Page���ض���
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
