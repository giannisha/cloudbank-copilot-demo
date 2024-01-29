import { API_HOST } from "$env/static/private";
import type { Notification, Transaction } from "./types"

export const getAccountsTransactions = async (token: string): Promise<Transaction[]> => {
  let trx: Transaction[] = []
  await fetch(`${API_HOST}/api/accounts/transactions`, {
    headers: {
      ContentType: 'application/json',
      Authorization: `Bearer ${token}`
    }
  }).then(async (res) => {
    if (res.status === 200) trx = await res.json()
  });
  return trx
}

export const getCardsTransactions = async (token: string): Promise<Transaction[]> => {
  let trx: Transaction[] = []
  await fetch(`${API_HOST}/api/cards/transactions`, {
    headers: {
      ContentType: 'application/json',
      Authorization: `Bearer ${token}`
    }
  }).then(async (res) => {
    if (res.status === 200) trx = await res.json()
  })
  return trx
}

export const getNotifications = async (token: string): Promise<Notification[]> => {
  let records: Notification[] = []
  await fetch(`${API_HOST}/api/notifications`, {
    headers: {
      ContentType: 'application/json',
      Authorization: `Bearer ${token}`
    }
  }).then(async (res) => {
    if (res.status === 200) records = await res.json()
  })
  return records
}