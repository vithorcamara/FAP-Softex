// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import type { NextApiRequest, NextApiResponse } from 'next'
import { decodeJWT } from '../../utils/verifyJWT'

type Data = {
  name: string
}

export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  if(decodeJWT(req)){
    return res.status(200).json({ name: 'John Doe' })
  }
  return res.status(401).json({ name: 'Unauthorized' })
}
