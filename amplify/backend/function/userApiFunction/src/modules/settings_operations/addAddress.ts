import { USERS_TABLE_NAME } from "./../config";
import * as uuid from "uuid";
import { addItem, getItem } from "../querys";

export async function addAddress(
  userId: string,
  address: any
): Promise<{ statuesCode: number; body: any }> {
  address.id = uuid.v4();

  var user = (await getItem(USERS_TABLE_NAME, userId)).Item;

  if (!user) {
    user = {};
  }

  if (!user.addresses) {
    user.addresses = [];
  }
  user.addresses.push(address);

  await addItem(USERS_TABLE_NAME, user);

  return { statuesCode: 200, body: "address saved" };
}
