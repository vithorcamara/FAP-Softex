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
  if (req.method === 'GET') {
    const db = (await clientPromise).db();
    const collection = db.collection('orders');
    console.log({ user: token._id });
    const orders = await collection.find({ user: new ObjectId(token._id) }).toArray();
    console.log({ orders });
    return res.status(200).json({ orders });
  }
  if (req.method === 'POST') {
    const { products, price } = req.body;
    const db = (await clientPromise).db();
    const collection = db.collection('orders');

    collection.insertOne({
      user: new ObjectId(token._id),
      isSuccessfullydDelivery: false,
      products: products,
      price: price,
      orderDateTimestamp: new Date().getTime(),
      receivedOrderDateTimestamp: null
    });
    console.log('order created');
    return res.status(201).json({ message: 'Order generated' });
  }

  if (req.method === 'PUT') {
    const { receivedOrderDateTimestamp, id } = req.body;
    const db = (await clientPromise).db();
    const collection = db.collection('orders');

    collection
      .updateOne(
        { _id: new ObjectId(id) },
        {
          $set: {
            isSuccessfullydDelivery: true,
            receivedOrderDateTimestamp
          }
        }
      )
      .catch((err) => {
        return res.status(404).json({ message: 'Order does not exist' });
      });

    return res.status(200).json({ message: 'Order generated' });
  }
}
