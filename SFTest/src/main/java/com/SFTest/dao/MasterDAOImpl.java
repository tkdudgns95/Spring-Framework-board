package com.SFTest.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.SFTest.dto.FileVO;

@Repository
public class MasterDAOImpl implements MasterDAO {

	@Autowired
	SqlSession sql;
	private static String namespace = "com.SFTest.mappers.Master";

	@Override
	public int filedeleteCount() {
		return sql.selectOne(namespace + ".filedeleteCount");
	}

	@Override
	public List<FileVO> filedeleteList() {
		return sql.selectList(namespace + ".filedeleteList");
	}

	@Override
	public void deleteFile(int fileseqno) {
		sql.delete(namespace + ".deleteFile", fileseqno);

	}

}
