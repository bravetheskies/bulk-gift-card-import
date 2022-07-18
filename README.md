# Bulk gift card import tool

Bulk gift card import tool is command line Ruby tool for [Shopify](https://www.shopify.com/).

:rotating_light: **This tool can only be used with [Shopify Plus](https://www.shopify.com/plus). You must create a custom app and [request the gift card API endpoint to be enabled](https://community.shopify.com/c/shopify-apis-and-sdks/gift-card-api-404-not-found-error/m-p/1397206/highlight/true#M74800) via [Shopify Plus Support](https://help.shopify.com/en/support).**

## Setup

The bulk gift card import tool is a simple Ruby command line tool. To install the package run:

```
bundle install
```

## Usage

To bulk import gift cards create a CSV in the following format:

| Code | Balance | Expires | Note |
| --- | --- | --- | --- |
| ABCD 1234 ABCD 1234 | 100.00 | 2025-01-01 | This is a note. |

```
ruby import.rb -f example.csv
```