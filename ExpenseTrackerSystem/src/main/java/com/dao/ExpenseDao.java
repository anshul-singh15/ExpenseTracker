package com.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.entity.Expenses;
import com.entity.User;

public class ExpenseDao {

	private SessionFactory factory = null;
	private Session session = null;
	private Transaction tx = null;

	public ExpenseDao(SessionFactory factory) {
		super();
		this.factory = factory;
	}

	public boolean saveExpense(Expenses ex) {
		boolean f = false;

		try {
			session = factory.openSession();
			tx = session.beginTransaction();

			session.save(ex);
			tx.commit();
			f = true;
		} catch (Exception e) {
			if (tx != null) {
				f = false;
				e.printStackTrace();
			}
		}
		return f;
	}

	public List<Expenses> getAllExpenseByUser(User user) {
		List<Expenses> list = new ArrayList<Expenses>();
		try {

			session = factory.openSession();
			Query q = session.createQuery("from Expenses where user=: u");
			q.setParameter("u", user);
			list = q.list();

		} catch (Exception e) {

			e.printStackTrace();
		}
		return list;
	}

	public Expenses getExpenseById(int id) {
		Expenses ex = null;

		try {

			session = factory.openSession();
			Query q = session.createQuery("from Expenses where id=: id");
			q.setParameter("id", id);
			ex = (Expenses)q.uniqueResult();

		} catch (Exception e) {

			e.printStackTrace();
		}

		return ex;
	}
	
	public boolean updateExpense(Expenses ex) {
		boolean f = false;

		try {
			session = factory.openSession();
			tx = session.beginTransaction();

			session.saveOrUpdate(ex);
			tx.commit();
			f = true;
		} catch (Exception e) {
			if (tx != null) {
				f = false;
				e.printStackTrace();
			}
		}
		return f;
	}
	
	public boolean deleteExpense(int id) {
		boolean f = false;

		try {
			session = factory.openSession();
			tx = session.beginTransaction();
			
			Expenses ex = session.get(Expenses.class, id);
			
			session.delete(ex);
			
			tx.commit();
			f = true;
		} catch (Exception e) {
			if (tx != null) {
				f = false;
				e.printStackTrace();
			}
		}
		return f;
	}
}