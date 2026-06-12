# IdentitiesOnly keeps ssh from offering agent keys first, which would
# expose the primary identity to the remote host
export GIT_SSH_COMMAND="ssh -i ${HOME}/.ssh/ofalkenberg_id_ed25519 -o IdentitiesOnly=yes"
