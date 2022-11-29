import { IUser } from './../auth/types';
import clientPromise from '../../../libs/mongodb';
import { NextApiRequest, NextApiResponse } from 'next';
import { decodeJWT } from '../../../utils/verifyJWT';
import { IToken } from '../auth/types';
import { ObjectId } from 'mongodb';
import NextCors from 'nextjs-cors';
import { IMovie } from '../movies/types';

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
  if (req.method === 'PUT') {
    const { username } = req.body;
    const db = (await clientPromise).db();
    const user = (await db.collection('users').findOne({ _id: new ObjectId(token._id) })) as unknown as IUser;

    if (!user) {
      return res.status(403).json({ message: 'User not found' });
    }

    user.username = username;

    await db.collection('users').updateOne({ _id: new ObjectId(token._id) }, { $set: user });

    return res.status(200).json({ message: 'User updated', user });
  } if (req.method === 'DELETE') {
    const db = (await clientPromise).db();
    const user = (await db.collection('users').findOne({ _id: new ObjectId(token._id) })) as unknown as IUser;

    if (!user) {
      return res.status(403).json({ message: 'User not found' });
    }
    await db.collection('users').deleteOne({ _id: new ObjectId(token._id) });

    res.status(200).json({ auth: false, token: null, user: null });
  }
}
