"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.BUCKET_NAME = exports.CARTS_TABLE_NAME = exports.ORDERS_TABLE_NAME = exports.PRODUCTS_TABLE_NAME = exports.FAVORITES_TABLE_NAME = exports.CATEGORIES_TABLE_NAME = void 0;
/* A template literal. */
exports.CATEGORIES_TABLE_NAME = `categories-${process.env.ENV}`;
exports.FAVORITES_TABLE_NAME = `favorites-${process.env.ENV}`;
exports.PRODUCTS_TABLE_NAME = `products-${process.env.ENV}`;
exports.ORDERS_TABLE_NAME = `orders-${process.env.ENV}`;
exports.CARTS_TABLE_NAME = `cart-${process.env.ENV}`;
exports.BUCKET_NAME = "ebraw5et058a2e99386f439d978ebd1f93bf685c214445-dev";
