package com.changh.sccms.dao;

import java.util.List;

import com.changh.sccms.entity.Answer;

public interface AnswerDAO {
	//find by 问题id
	public List<Answer> findByQuestionId(int questionId)throws Exception;
	//保存答案
	public void save(Answer answer)throws Exception;
}
