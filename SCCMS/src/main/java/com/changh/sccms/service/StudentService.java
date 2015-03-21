package com.changh.sccms.service;

import java.util.List;

import com.changh.sccms.entity.ExamRecord;
import com.changh.sccms.entity.Student;
import com.changh.sccms.entity.StudyRecord;

public interface StudentService {
	//findAll
	public List<Student> studentList(int page,int pagesize,String sortName,String sortOrder) throws Exception;
	public void deleteStudent(int stuId) throws Exception;
	public Student updateStudent(int stuId) throws Exception;
	public void modifyStudent(Student stu) throws Exception;
	public List<Student> studentSelect(String date,int page,int pagesize,String sortname,String sortorder) throws Exception;
	
	//新增
	public void addStudent(Student stu)throws Exception;
	//find by username
	public Student findByUsername(String username)throws Exception;
	//find by email
	public Student findByEmail(String email)throws Exception;
	//find by id
	public Student findById(int id)throws Exception;
	//总数
	public int getTotal(String date);
	/**
	 * 查询
	 * @param page
	 * @param pagesize
	 * @param sortname
	 * @param sortorder
	 * @param str
	 * @param searchName
	 * @return
	 * @throws Exception
	 */
	public List<Student> search(int page,int pagesize,String sortname,String sortorder,String str,String searchName)throws Exception;
	
	//手动充现金值
	public boolean updateAccount(int stuId,double money,String tradePattern,String content)throws Exception;
	/**
	 * total
	 * @param searchName
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public int getSearchTotal(String searchName,String str) throws Exception;
	/**
	 * 查找学选的学习记录
	 * @param stuId
	 * @return
	 */
	public List<StudyRecord>  findStudyRecord(int stuId,int page,int pagesize,String sortname,String sortorder);
	/**
	 * 查找学员的考试记录
	 * @param stuId
	 * @return
	 */
	public List<ExamRecord> findExamRecord(int stuId,int page,int pagesize,String sortname,String sortorder);
	/**
	 * 学习记录总条数
	 * @param stuId
	 * @return
	 */
	public Integer getStudyRecordTotal(int stuId);
	/**
	 * 考试记录总条数
	 * @param stuId
	 * @return
	 */
	public Integer getExamRecordTotal(int stuId);
}
