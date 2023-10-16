package com.board.mvc.repository;

import org.springframework.stereotype.Repository;

import com.board.mvc.domain.Favorites;

@Repository
public interface FavoritesRepository {

	int save(Favorites favorites);
	int delete(Favorites favorites);
	int check(Favorites favorites);
}
