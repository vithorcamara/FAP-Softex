import { IUser } from './../auth/types';
import clientPromise from '../../../libs/mongodb';
import { NextApiRequest, NextApiResponse } from 'next';
import { IMovie } from './types';
import { decodeJWT } from '../../../utils/verifyJWT';
import { IToken } from '../auth/types';
import { ObjectId } from 'mongodb';
import NextCors from 'nextjs-cors';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  await NextCors(req, res, {
    // Options
    methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE'],
    origin: '*',
    optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204
  });
  const token = decodeJWT(req) as unknown as IToken;
  if (!token) {
    return res.status(401).json({ message: 'Unauthorized' });
  }
  if (req.method === 'POST') {
    const data = req.body as IMovie;
    const db = (await clientPromise).db();
    const user = (await db.collection('users').findOne({ _id: new ObjectId(token._id) })) as unknown as IUser;

    if (!user) {
      return res.status(403).json({ message: 'User not found' });
    }

    user.watchedMovies.push(data);
    user.totalTimeWatched += data.runtime;

    await db.collection('users').updateOne({ _id: new ObjectId(token._id) }, { $set: { watchedMovies: user.watchedMovies, totalTimeWatched: user.totalTimeWatched } });

    return res.status(201).json({ message: 'Movie added', user });
  } if (req.method === 'DELETE') {
    const movieID = parseInt(req.query.id as string);
    const db = (await clientPromise).db();
    const user = (await db.collection('users').findOne({ _id: new ObjectId(token._id) })) as unknown as IUser;

    if (!user) {
      return res.status(403).json({ message: 'User not found' });
    }

    const movieToRemove = user.watchedMovies.find((movie) => movie.id === movieID);
    if (!movieToRemove) {
      return res.status(404).json({ message: 'Movie not found' });
    }
    user.watchedMovies = user.watchedMovies.filter((item) => item.id !== movieID);
    console.log(user.totalTimeWatched, movieToRemove.runtime)
    user.totalTimeWatched = user.totalTimeWatched - movieToRemove.runtime;

    await db.collection('users').updateOne({ _id: new ObjectId(token._id) }, { $pull: { watchedMovies: { id: movieID } }, $set: { totalTimeWatched: user.totalTimeWatched } });

    return res.status(200).json({ message: 'Movie added', user });
  }
}
