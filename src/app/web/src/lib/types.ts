export interface Transaction {
  id: number;
  from: string;
  to: string;
  date: string;
  description: string;
  category: string;
  type: string;
  amount: number;
}

export interface Notification {
  id: string;
  imgSrc: string;
  title: string;
  description: string;
  comments: string;
  date: string;
}

export interface User {
  id: string;
  username: string;
  name: string;
}

export interface AuthUser extends User {
  token: string;
}