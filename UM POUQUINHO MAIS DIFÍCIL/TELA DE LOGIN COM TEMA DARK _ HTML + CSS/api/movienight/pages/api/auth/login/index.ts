import jwt from 'jsonwebtoken';
import clientPromise from '../../../../libs/mongodb';
import { NextApiRequest, NextApiResponse } from 'next';
import { IUser } from './../types';
import NextCors from 'nextjs-cors';


export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  await NextCors(req, res, {
    // Options
    methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE'],
    origin: '*',
    optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204
 });
  const jwtKey = process.env.JWTKEY;
  if(req.method === 'POST'){
    const { username, password } = req.body;
    const db = (await clientPromise).db();
    const user = (await db
      .collection('users')
      .findOne({
        username,
        password
      })) as unknown as IUser;
    const token = jwt.sign(user, jwtKey as string, {
      expiresIn: "7d" // expires in 7 days
    });
    return res.json({ auth: true, token, user });
  }
}