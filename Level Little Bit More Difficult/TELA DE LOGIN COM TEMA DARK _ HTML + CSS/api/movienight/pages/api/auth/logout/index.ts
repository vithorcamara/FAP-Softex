import { NextApiRequest, NextApiResponse } from 'next';
import { IToken } from './../types';
import { decodeJWT } from '../../../../utils/verifyJWT';
import NextCors from 'nextjs-cors';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  await NextCors(req, res, {
    // Options
    methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE'],
    origin: '*',
    optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204
 });
  const token = decodeJWT(req) as unknown as IToken;
  if (!token) {
    return res.status(401).json({ message: 'Unauthorized' });
  }
  res.status(200).json({ auth: false, token: null, user: null });
}
