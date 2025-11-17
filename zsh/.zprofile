# start keychain
keychain --clear --agents "ssh,gpg" git 0x9CC9729A2E369CB3

[ -z "$HOSTNAME" ] && HOSTNAME=$(uname -n)

[ -f $HOME/.keychain/$HOSTNAME-sh ] && \
   . $HOME/.keychain/$HOSTNAME-sh

[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
   . $HOME/.keychain/$HOSTNAME-sh-gpg

# Infinality conf
#if [ -r $HOME/.infinality ] ; then
#    source $HOME/.infinality
#fi
