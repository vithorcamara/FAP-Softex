import clientPromise from '../../../libs/mongodb';
import { NextApiRequest, NextApiResponse } from 'next';
import { IUser } from './types';
import NextCors from 'nextjs-cors';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  await NextCors(req, res, {
    // Options
    methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE'],
    origin: '*',
    optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204
 });
  if (req.method === 'POST') {
    console.log('req.body: ', req.body);
    const { username, password } = req.body;
    const db = (await clientPromise).db();
    const usersWithSameInfos = (await db
      .collection('users')
      .find({
        username: req.body['username']
      })
      .toArray()) as unknown as IUser[];
    if (usersWithSameInfos.length > 0) {
      return res.status(401).json({ message: 'This user has already an owner' });
    }

    await db.collection('users').insertOne({
      username: req.body['username'],
      password: req.body['password'],
      watchedMovies: [],
      totalTimeWatched: 0
    });

    return res.status(201).json({ message: 'User created' });
  }
}
