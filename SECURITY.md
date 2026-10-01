# Security and credential hygiene

## Public repository

This repository is public. Treat every committed credential as disclosed.

## O6 cleanup

On 2026-10-01, generated local-lab token artifacts were removed from the current `main` tree.

The removed files had contained OAuth access/refresh token responses from a localhost lab.

Deleting files from `main` does **not** erase them from Git history.

## Required response

For any environment whose credential or token was ever committed:
1. assume disclosure;
2. revoke/rotate the credential if the environment still exists;
3. invalidate relevant sessions where appropriate;
4. do not reuse the value;
5. only then consider history rewriting if policy requires it.

## Never commit

- access tokens;
- refresh tokens;
- ID tokens;
- session cookies;
- kubeconfig;
- private keys;
- client secrets;
- database passwords;
- bootstrap admin credentials;
- unredacted vault/secret-manager output.

## Lab rule

Demo usernames are acceptable documentation.

Passwords and client secrets must be injected from environment variables or created at runtime, not stored in versioned runtime manifests.

## Evidence

Evidence files should contain:
- timestamps;
- status codes;
- resource names;
- health/sync states;
- sanitized claims;
- hashes/digests where useful.

They should never contain bearer credentials.
