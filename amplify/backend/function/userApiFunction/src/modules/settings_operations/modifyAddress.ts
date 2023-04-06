import { USERS_TABLE_NAME } from "./../config";
import * as uuid from "uuid";
import { addItem, getItem } from "../querys";

export async function modifyAddress(
  userId: string,
  address: any
): Promise<{ statuesCode: number; body: any }> {
  var user = (await getItem(USERS_TABLE_NAME, userId)).Item;

  if (!user) {
    return {
      statuesCode: 404,
      body: "Couldn't find user",
    };
  }

  const index = (user.addresses as any[]).findIndex((e) => e.id === address.id);
  user.addresses[index] = address;
  await addItem(USERS_TABLE_NAME, user);

  return { statuesCode: 200, body: "address saved" };
}
