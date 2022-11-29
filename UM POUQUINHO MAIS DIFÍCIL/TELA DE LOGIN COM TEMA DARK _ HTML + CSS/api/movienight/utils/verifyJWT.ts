import { NextApiRequest } from "next";
import jwt from 'jsonwebtoken';

export function decodeJWT(req: NextApiRequest){
    const token = req.headers['x-access-token'];
    if (!token) return false;
    
    return jwt.verify(token as string, process.env.JWTKEY as string, function(err, decoded) {
      if (err) return false;
      return decoded;
    });
}