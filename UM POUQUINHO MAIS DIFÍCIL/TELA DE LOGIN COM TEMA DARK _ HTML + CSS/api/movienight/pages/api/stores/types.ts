export interface IStoreItem {
  name: string;
  description: string;
  price: number;
  image: string;
}

export interface IStoreItemBody {
  movieID: number;
  item: IStoreItem;
}