import { IMovie } from "../movies/types";

export interface signupRequest {
  username: string;
  password: string;
}

export interface IUser {
  _id: string;
  username: string;
  password: string;
  watchedMovies: IMovie[],
  totalTimeWatched: number,
}

export interface IToken {
  _id: string;
  username: string;
  password: string;
  iat: number;
  exp: number;
}