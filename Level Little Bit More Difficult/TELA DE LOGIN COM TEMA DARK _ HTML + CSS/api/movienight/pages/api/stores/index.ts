import { IStoreItem, IStoreItemBody } from './types';
import clientPromise from '../../../libs/mongodb';
import { NextApiRequest, NextApiResponse } from 'next';
import { decodeJWT } from '../../../utils/verifyJWT';
import { IToken } from '../auth/types';
import { Int32, ObjectId } from 'mongodb';
import NextCors from 'nextjs-cors';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  await NextCors(req, res, {
    // Options
    methods: ['GET', 'HEAD', 'PUT', 'PATCH', 'POST', 'DELETE'],
    origin: '*',
    optionsSuccessStatus: 200, // some legacy browsers (IE11, various SmartTVs) choke on 204
 });
  if (req.method === 'POST') {
    const token = decodeJWT(req) as unknown as IToken;
    if (!token) {
      return res.status(401).json({ message: 'Unauthorized' });
    }
    const db = (await clientPromise).db();
    const item = req.body as IStoreItemBody;
    await db.collection('products').insertOne(item)

    return res.status(201).json({ message: 'Item added' });
  }
  else if(req.method === 'GET'){
    const token = decodeJWT(req) as unknown as IToken;
    if (!token) {
      return res.status(401).json({ message: 'Unauthorized' });
    }
    const { movieID } = req.query;
    const db = (await clientPromise).db();
    
    const products = await db.collection('products').find({ movieID: new Int32(movieID as string) }).toArray() as unknown as IStoreItem[];
    console.log(products);
    if(products === null){
      return res.status(200).json({ products: {
        products: []
      } })
    }
    return res.status(200).json({ store: {
      products: products
    } });
  }
}
