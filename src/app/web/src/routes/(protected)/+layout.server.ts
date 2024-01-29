import type { AuthUser } from "$lib/types.js";

export const load = async ({ cookies }) => {
  const token = cookies.get('accessToken');

  if (!token) return;

  const accountInfo = cookies.get('account');

  const user = {
    id: cookies.get('userId'),
    username: cookies.get('username'),
    token: cookies.get('accessToken'),
    name: accountInfo ? JSON.parse(accountInfo).name : '',
  } as AuthUser;

  return {
    user
  }
}