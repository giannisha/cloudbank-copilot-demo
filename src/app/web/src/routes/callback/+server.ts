import { json, redirect } from "@sveltejs/kit";
import type { RequestHandler } from "./$types";
import { getTokens } from "$lib/auth/service";

export const GET: RequestHandler = async (event) => {
  const redirectTo = await getTokens(event);
  if (!redirectTo) json({ error: "Invalid state" });
  throw redirect(302, redirectTo);
};

export const OPTIONS = async () => {
  return {
    status: 200,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "*",
      "Access-Control-Allow-Headers": "*",
    },
  };
}