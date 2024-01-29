import { getAccountsTransactions, getCardsTransactions } from "$lib/api"

export const load = async ({ cookies }) => {
  const token = cookies.get('accessToken');

  if (!token) return;

  const accountsTransactions = await getAccountsTransactions(token) ?? [];
  const cardsTransactions = await getCardsTransactions(token) ?? [];

  return {
    accountsTransactions,
    cardsTransactions,
  }
}