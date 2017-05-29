#!/bin/bash

[ -z "$GITHUB_HTTPS_URL" ] && echo "You need to set GITHUB_HTTPS_URL - e.g. GITHUB_HTTPS_URL=https://github.com/repository/repo_name.git" && exit 1;
[ -z "$ANSIBLE_PLAYBOOK" ] && echo "You need to set ANSIBLE_PLAYBOOK - e.g. ANSIBLE_PLAYBOOK=deploy.yml" && exit 1;
[ -z "$ANSIBLE_HOSTS" ] && echo "You need to set ANSIBLE_HOSTS - e.g. ANSIBLE_HOSTS=host.ini" && exit 1;
[ -z "$ANSIBLE_ROLES_FOLDER" ] && echo "You need to set ANSIBLE_ROLES_FOLDER - e.g. ANSIBLE_ROLES_FOLDER=/var/tmp/user-repository/roles" && exit 1;
[ -z "$ANSIBLE_REQUIREMENTS_FILE" ] && echo "You need to set ANSIBLE_REQUIREMENTS_FILE - e.g. ANSIBLE_REQUIREMENTS_FILE=/var/tmp/user-repository/requirements.yml" && exit 1;
[ -z "$ANSIBLE_SSH_USER" ] && echo "You need to set ANSIBLE_SSH_USER - e.g. ANSIBLE_SSH_USER=user" && exit 1;
[ -z "$GIT_REPOSITORY" ] && echo "You need to set GIT_REPOSITORY - e.g. GIT_REPOSITORY=/var/tmp/user-repository" && exit 1;
[ -z "$GITHUB_BRANCH" ] && echo "You need to set GITHUB_BRANCH - e.g. GITHUB_BRANCH=master" && exit 1;

if [ -n "$ANSIBLE_VAULT_PASSWORD" ]; then
echo "Creating Vault-file: ${ANSIBLE_VAULT_FILE}"
/bin/cat <<EOM >$ANSIBLE_VAULT_FILE
${ANSIBLE_VAULT_PASSWORD}
EOM
fi

if [ ! -d "${GIT_REPOSITORY}" ]; then
    echo "Cloning ${GITHUB_HTTPS_URL}:${GITHUB_BRANCH} into ${GIT_REPOSITORY}"
    git clone "${GITHUB_HTTPS_URL}" "${GIT_REPOSITORY}" -b "${GITHUB_BRANCH}"
fi

if [ ! -d "${ANSIBLE_ROLES_FOLDER}" ]; then
    echo "Installing roles into ${ANSIBLE_ROLES_FOLDER}"
    ansible-galaxy install -r "${ANSIBLE_REQUIREMENTS_FILE}" -p "${ANSIBLE_ROLES_FOLDER}" -i
fi

if [ -d "${GIT_REPOSITORY}" ]; then
    echo "Ansible run"
    (cd "${GIT_REPOSITORY}"; ansible-playbook -i "${ANSIBLE_HOSTS}" "${ANSIBLE_PLAYBOOK}" -u "${ANSIBLE_SSH_USER}")
fi

if [ -f "${ANSIBLE_VAULT_FILE}" ]; then
    shred "${ANSIBLE_VAULT_FILE}"
fi

if [ -d "${GIT_REPOSITORY}" ]; then
    rm -r -l "${GIT_REPOSITORY}"
fi