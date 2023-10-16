package com.board.mvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.mvc.domain.Comment;
import com.board.mvc.domain.Member;
import com.board.mvc.repository.CommentRepository;
import com.board.mvc.repository.MemberRepository;

@Service

public class CommentService {
	@Autowired
	private CommentRepository repository;
	@Autowired
	private MemberRepository memberRepository;

	
	public void save(Comment comment) {
		repository.save(comment);
	}

	// 삭제할거 전체조회기
	public List<Comment> getList(int boardId) {
		return repository.getList(boardId);
	}
	
	public boolean delete(String memberPw, int commentId) {
		String memberId = repository.get(commentId).getMemberId();
		Member member = new Member();
		member.setId(memberId);
		member.setPassword(memberPw);
		boolean pwCheck = memberRepository.idcheck(member)!=0;
		
		if (pwCheck) {
			repository.delete(commentId);
		}		
		return pwCheck;		
	}
	
	//삭제할거 게시물 삭제시해당게시물 데이터 삭제
	public void deleteBoardAll(int boardId) {
		repository.deleteBoardAll(boardId);
	}
	
	//삭제할거  유저삭제시 데이터 삭제 유저에서 올거
	public void deleteUserAll(String id) {
		repository.deleteMemberAll(id);
	}
}
