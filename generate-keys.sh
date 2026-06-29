#!/usr/bin/env bash
# CodeAlpha DevOps - Tâche 2 : Jenkins Remoting Project
# Génère une paire de clés SSH dédiée UNIQUEMENT à la connexion
# contrôleur -> agents de cette démo. Ne jamais réutiliser cette clé
# pour autre chose, et ne jamais la committer dans Git (déjà exclue
# via .gitignore).

set -euo pipefail

KEY_DIR="agent/ssh"
KEY_PATH="${KEY_DIR}/id_rsa"

mkdir -p "${KEY_DIR}"

if [ -f "${KEY_PATH}" ]; then
  echo "Une clé existe déjà dans ${KEY_PATH}. Supprime-la d'abord si tu veux la régénérer."
  exit 1
fi

ssh-keygen -t rsa -b 4096 -N "" -f "${KEY_PATH}" -C "jenkins-remoting-demo-codealpha"

echo ""
echo "Clé SSH générée avec succès dans ${KEY_DIR}/"
echo ""
echo "Prochaine étape, exporte les variables d'environnement nécessaires :"
echo ""
echo "  export AGENT_SSH_PUBKEY=\"\$(cat ${KEY_PATH}.pub)\""
echo "  export AGENT_SSH_PRIVATE_KEY=\"\$(cat ${KEY_PATH})\""
echo "  export JENKINS_ADMIN_PASSWORD=\"choisis-un-mot-de-passe-fort\""
echo ""
echo "Puis : docker compose up -d --build"
