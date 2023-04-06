import { USERS_TABLE_NAME } from "../config";
import { getItem } from "../querys";

export async function getUserData(
  userId: string
): Promise<{ statuesCode: number; body: any }> {
  const user = (await getItem(USERS_TABLE_NAME, userId)).Item;

  return { statuesCode: 200, body: user };
}
