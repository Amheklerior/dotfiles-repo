# How sensitive information are protected

SSH keys are stored under the [`/ssh-keys`](/ssh-keys/) directory. Private keys are symmetrically encrypted using [`ansible-vault`](https://docs.ansible.com/ansible/latest/vault_guide/index.html), while the public ones are stored in clear form.

A git pre-commit hook has been setup. The hook runs [`gitleaks`](https://github.com/zricethezav/gitleaks) agaist the staged changes to make sure no secrets get accidentally leaked to the public.

