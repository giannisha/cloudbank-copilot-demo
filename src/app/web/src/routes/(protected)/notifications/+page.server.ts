import { getNotifications } from "$lib/api"

export const load = async ({ cookies }) => {
  const token = cookies.get('accessToken');

  if (!token) return;

  const records = await getNotifications(token) ?? [];

  return {
    records
  }
}