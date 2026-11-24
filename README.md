# never-sleep-erp

Keeps the IIT KGP ERP session alive so you don't have to log in again. Every
2 minutes it sends your `ssoToken` cookie to
`https://erp.iitkgp.ac.in/IIT_ERP3/keepAlive.htm` with curl.

It only works while your laptop is awake. If the laptop sleeps for too long,
the session dies anyway, and the script asks you for a fresh token.

## Get the token (hackermode)

1. Log in to ERP in Chrome.
2. Open DevTools with `Cmd+Option+I`.
3. Go to Application → Cookies → `https://erp.iitkgp.ac.in`.
4. Copy the value of `ssoToken`.

## Run

```sh
./neversleep.erp.sh
```

Paste the token at the prompt. Nothing shows while you paste. The token stays
in memory only: it never goes to disk, shell history or `ps`.

What it prints:

- `200`: the session is alive.
- `000`: ERP could not be reached (Wi-Fi). It tries again in 2 minutes.
- Anything else: the session is dead. It rings the bell and asks for a new
  token. Log in again, copy the new `ssoToken`, and paste it.

Stop it with `Ctrl-C`.

## After a Chrome restart

Turn on Chrome's Settings → On startup → "Continue where you left off". Chrome
then keeps the `ssoToken` cookie across restarts, so your ERP tab stays logged
in as long as the script kept the session alive.
