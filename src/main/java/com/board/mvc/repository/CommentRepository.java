package com.board.mvc.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.board.mvc.domain.Comment;

@Repository
public interface CommentRepository {
	
	void save(Comment comment);
	
//게시물에서 상위 레파지토리로 요청할거임 테스트로 하나 만들예정
	List<Comment> getList(int boardId);
	
	Comment get(int commentId);
	 
	void delete(int commentId);
	
//삭제시 게시물 아이디로 삭제함 boardServic에서 요청
	void deleteBoardAll(int boardId);

//유저삭제시 유저작성 댓글 모두 삭제 MemberService 에서 요
	void deleteMemberAll(String id);
}
