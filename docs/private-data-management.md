# How sensitive information are protected

Sensitive and private data, such as 2FA backup codes, SSH private keys, access tokens, licence keys, etc. are all encrypted with a passphrase using [`ansible-vault`](https://docs.ansible.com/ansible/latest/vault_guide/index.html).

SSH key pairs are safely stored under the [`/ssh-keys`](/ssh-keys/) directory. The private keys are stored encrypted, while the public ones are stored in clear form.

2FA codes, licence keys, recovery keys, and tokens for apps and services are stored encrypted under the [`/secrets`](/secrets/) directory.

A git pre-commit hook has been setup. The hook runs [`gitleaks`](https://github.com/zricethezav/gitleaks) and some more custom checks agaist the staged changes to make sure no secrets get accidentally leaked to the public.

> _**NOTE**: an exploration has been made for using [`gnupg`](https://www.gnupg.org) as alternative to [`ansible-vault`](https://docs.ansible.com/ansible/latest/vault_guide/index.html) for encrypting/decrypting sensitive information contained in the repository. In the end, the "ansible" approach has been kept over the gpg alternative, improved from the learnings of using gpg. Details are contained in the [relative PR](https://github.com/Amheklerior/dotfiles-repo/pull/1)._
